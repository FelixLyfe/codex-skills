#!/usr/bin/env bash

set -u

usage() {
  printf 'Usage: %s [PROJECT_DIR]\n' "$0" >&2
}

if [[ $# -gt 1 ]]; then
  usage
  exit 2
fi

project_dir=""
if [[ $# -eq 1 ]]; then
  if [[ ! -d "$1" ]]; then
    printf 'PROJECT_DIR is not a directory: %s\n' "$1" >&2
    exit 2
  fi
  project_dir="$(cd "$1" && pwd -P)"
fi

print_value() {
  local key="$1"
  local value="${2:-NOT_FOUND}"
  printf '%-28s %s\n' "${key}:" "$value"
}

command_path() {
  command -v "$1" 2>/dev/null || true
}

capture_flat() {
  local output
  local status
  local flat
  output="$("$@" 2>&1)"
  status=$?
  flat="$(printf '%s\n' "$output" | awk '
    NF {
      if (seen) {
        printf " | "
      }
      printf "%s", $0
      seen = 1
    }
    END {
      print ""
    }
  ')"

  if [[ $status -ne 0 ]]; then
    printf 'COMMAND_FAILED(%s): %s\n' "$status" "${flat:-NO_OUTPUT}"
  else
    printf '%s\n' "${flat:-NO_OUTPUT}"
  fi
}

path_or_missing() {
  if [[ -n "$1" ]]; then
    printf '%s\n' "$1"
  else
    printf 'NOT_FOUND\n'
  fi
}

json_string_value() {
  local file="$1"
  local key="$2"
  sed -n "s/^[[:space:]]*\"${key}\": \"\([^\"]*\)\".*/\1/p" "$file" 2>/dev/null | awk 'NR == 1 {print; exit}'
}

arch_value="$(uname -m 2>/dev/null || true)"
macos_value="$(sw_vers -productVersion 2>/dev/null || true)"
disk_value="$(df -h / 2>/dev/null | awk 'NR == 2 {print $4 " available of " $2}')"

rosetta_value="NOT_APPLICABLE"
if [[ "$arch_value" == "arm64" ]]; then
  if /usr/bin/arch -x86_64 /usr/bin/true >/dev/null 2>&1; then
    rosetta_value="AVAILABLE"
  else
    rosetta_value="NOT_DETECTED"
  fi
fi

brew_path="$(command_path brew)"
flutter_path="$(command_path flutter)"
dart_path="$(command_path dart)"
fvm_path="$(command_path fvm)"
adb_path="$(command_path adb)"
sdkmanager_path="$(command_path sdkmanager)"
java_path="$(command_path java)"
pod_path="$(command_path pod)"

flutter_version_value="NOT_PROBED"
dart_version_value="NOT_PROBED"
if [[ -n "$flutter_path" ]]; then
  flutter_bin_dir="$(cd "$(dirname "$flutter_path")" 2>/dev/null && pwd -P)"
  flutter_sdk_root="${flutter_bin_dir%/bin}"
  flutter_version_file="$flutter_sdk_root/bin/cache/flutter.version.json"
  dart_version_file="$flutter_sdk_root/bin/cache/dart-sdk/version"

  if [[ -f "$flutter_version_file" ]]; then
    flutter_framework_version="$(json_string_value "$flutter_version_file" "frameworkVersion")"
    flutter_channel="$(json_string_value "$flutter_version_file" "channel")"
    flutter_version_value="${flutter_framework_version:-UNKNOWN} (${flutter_channel:-UNKNOWN})"
  fi

  if [[ -f "$dart_version_file" ]]; then
    dart_version_value="$(sed -n '1p' "$dart_version_file")"
  fi
fi

fvm_version_value="NOT_PROBED"
if [[ -n "$fvm_path" && -f "$fvm_path" ]]; then
  fvm_version_value="$(sed -n 's/^# Version: //p' "$fvm_path" | awk 'NR == 1 {print; exit}')"
  fvm_version_value="${fvm_version_value:-NOT_PROBED}"
fi

xcode_select_value="$(xcode-select -p 2>/dev/null || true)"
xcode_version_value=""
if [[ -n "$(command_path xcodebuild)" ]]; then
  xcode_version_value="$(capture_flat xcodebuild -version)"
fi

android_studio_value="NOT_FOUND"
if [[ -d "/Applications/Android Studio.app" ]]; then
  android_studio_value="/Applications/Android Studio.app"
fi

android_sdk_value="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Library/Android/sdk}}"
if [[ ! -d "$android_sdk_value" ]]; then
  android_sdk_value="NOT_FOUND (checked ${android_sdk_value})"
fi

printf 'Flutter macOS environment preflight\n'
printf '%s\n' '----------------------------------'
print_value "Architecture" "$arch_value"
print_value "macOS" "$macos_value"
print_value "Shell" "${SHELL:-UNKNOWN}"
print_value "Root disk" "$disk_value"
print_value "Rosetta" "$rosetta_value"
print_value "Homebrew path" "$(path_or_missing "$brew_path")"
if [[ -n "$brew_path" ]]; then
  print_value "Homebrew version" "$(capture_flat brew --version)"
fi
print_value "Xcode CLI selection" "$(path_or_missing "$xcode_select_value")"
print_value "Xcode version" "$(path_or_missing "$xcode_version_value")"
print_value "Global Flutter path" "$(path_or_missing "$flutter_path")"
if [[ -n "$flutter_path" ]]; then
  print_value "Global Flutter version" "$flutter_version_value"
fi
print_value "Global Dart path" "$(path_or_missing "$dart_path")"
if [[ -n "$dart_path" ]]; then
  print_value "Global Dart version" "$dart_version_value"
fi
print_value "FVM path" "$(path_or_missing "$fvm_path")"
if [[ -n "$fvm_path" ]]; then
  print_value "FVM version" "$fvm_version_value"
fi
print_value "Android Studio" "$android_studio_value"
print_value "Android SDK" "$android_sdk_value"
print_value "adb path" "$(path_or_missing "$adb_path")"
print_value "sdkmanager path" "$(path_or_missing "$sdkmanager_path")"
print_value "Java path" "$(path_or_missing "$java_path")"
if [[ -n "$java_path" ]]; then
  print_value "Java version" "$(capture_flat java -version)"
fi
print_value "CocoaPods path" "$(path_or_missing "$pod_path")"
if [[ -n "$pod_path" ]]; then
  print_value "CocoaPods version" "$(capture_flat pod --version)"
fi

if [[ -n "$project_dir" ]]; then
  printf '\nProject\n'
  printf '%s\n' '-------'
  print_value "Project path" "$project_dir"

  project_flutter_version=""
  if [[ -f "$project_dir/.fvmrc" ]]; then
    project_flutter_version="$(json_string_value "$project_dir/.fvmrc" "flutter")"
    if [[ -n "$project_flutter_version" ]]; then
      print_value ".fvmrc Flutter" "$project_flutter_version"
    else
      print_value ".fvmrc" "PRESENT (Flutter version not parsed)"
    fi
  else
    print_value ".fvmrc" "NOT_FOUND"
  fi

  if [[ -f "$project_dir/.metadata" ]]; then
    print_value ".metadata" "PRESENT"
  else
    print_value ".metadata" "NOT_FOUND"
  fi

  project_sdk_link="$project_dir/.fvm/flutter_sdk"
  resolved_project_sdk=""
  if [[ -L "$project_sdk_link" ]]; then
    project_sdk_target="$(readlink "$project_sdk_link" 2>/dev/null || true)"
    if [[ -e "$project_sdk_link" ]]; then
      resolved_project_sdk="$(cd "$project_sdk_link" 2>/dev/null && pwd -P)"
      print_value "Project SDK link" "RESOLVED -> ${resolved_project_sdk}"
    else
      print_value "Project SDK link" "DANGLING -> ${project_sdk_target:-UNKNOWN}"
    fi
  elif [[ -d "$project_sdk_link" ]]; then
    resolved_project_sdk="$(cd "$project_sdk_link" 2>/dev/null && pwd -P)"
    print_value "Project SDK link" "DIRECTORY -> ${resolved_project_sdk}"
  elif [[ -e "$project_sdk_link" ]]; then
    print_value "Project SDK link" "PRESENT (not a directory or symlink)"
  else
    print_value "Project SDK link" "MISSING"
  fi

  resolved_project_sdk_version=""
  if [[ -n "$resolved_project_sdk" ]]; then
    resolved_project_version_file="$resolved_project_sdk/bin/cache/flutter.version.json"
    if [[ -f "$resolved_project_version_file" ]]; then
      resolved_project_sdk_version="$(json_string_value "$resolved_project_version_file" "frameworkVersion")"
    fi

    project_sdk_match="UNKNOWN"
    if [[ -n "$project_flutter_version" && -n "$resolved_project_sdk_version" ]]; then
      if [[ "$project_flutter_version" == "$resolved_project_sdk_version" ]]; then
        project_sdk_match="MATCH"
      else
        project_sdk_match="MISMATCH; declared ${project_flutter_version}"
      fi
    fi
    if [[ -n "$resolved_project_sdk_version" ]]; then
      print_value "Project SDK version" "${resolved_project_sdk_version} (${project_sdk_match})"
    else
      print_value "Project SDK version" "UNKNOWN"
    fi
  else
    print_value "Project SDK version" "NOT_PROBED"
  fi

  pinned_sdk_path=""
  if [[ -n "$project_flutter_version" ]]; then
    for fvm_cache_root_candidate in "${FVM_CACHE_PATH:-}" "$HOME/fvm" "$HOME/.fvm"; do
      if [[ -n "$fvm_cache_root_candidate" && -d "$fvm_cache_root_candidate/versions/$project_flutter_version" ]]; then
        pinned_sdk_path="$fvm_cache_root_candidate/versions/$project_flutter_version"
        break
      fi
    done

    if [[ -z "$pinned_sdk_path" && "$resolved_project_sdk_version" == "$project_flutter_version" ]]; then
      pinned_sdk_path="$resolved_project_sdk"
    fi
  fi

  if [[ -n "$pinned_sdk_path" ]]; then
    print_value "Pinned FVM SDK" "INSTALLED -> ${pinned_sdk_path}"
    pinned_dart_path="$pinned_sdk_path/bin/cache/dart-sdk/bin/dart"
    if [[ -f "$pinned_dart_path" ]]; then
      print_value "Pinned Dart architecture" "$(capture_flat file "$pinned_dart_path")"
    else
      print_value "Pinned Dart architecture" "NOT_FOUND"
    fi
  elif [[ -n "$project_flutter_version" ]]; then
    expected_fvm_cache_root="${FVM_CACHE_PATH:-$HOME/fvm}"
    print_value "Pinned FVM SDK" "MISSING (checked ${expected_fvm_cache_root}/versions/${project_flutter_version})"
    print_value "Pinned Dart architecture" "NOT_PROBED"
  else
    print_value "Pinned FVM SDK" "UNKNOWN (no parsed .fvmrc Flutter version)"
    print_value "Pinned Dart architecture" "NOT_PROBED"
  fi

  if git -C "$project_dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    project_revision="$(git -C "$project_dir" rev-parse --short HEAD 2>/dev/null || true)"
    project_dirty="CLEAN"
    if [[ -n "$(git -C "$project_dir" status --porcelain 2>/dev/null)" ]]; then
      project_dirty="DIRTY"
    fi
    print_value "Git revision" "$project_revision"
    print_value "Git worktree" "$project_dirty"
  else
    print_value "Git worktree" "NOT_A_REPOSITORY"
  fi
fi

printf '\nPreflight complete. Missing tools are inventory results, not automatic failures.\n'
