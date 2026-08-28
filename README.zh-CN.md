# Codex Skills

[English](README.md)

这个仓库收录四份面向 Codex 的开发 Skill，分别处理 API 契约接入、Apple Silicon macOS 上的 Flutter 环境搭建、UniApp 到 Flutter 的等价迁移，以及 MasterGo 设计在 UniApp 中的实现。

每份 Skill 都支持根据描述自动触发，也可以在提示词中通过 `$skill-name` 显式调用。需要严格控制任务模式或修改范围时，推荐显式调用。

## 安装

### 从本地目录安装

在仓库根目录查看可安装的 Skill：

```bash
npx skills add . --list
```

安装一份 Skill 到 Codex 用户级目录：

```bash
npx skills add . --skill devops-api-doc-to-code --agent codex -g
```

### 从 GitHub 安装

先查看仓库中的 Skill：

```bash
npx skills add FelixLyfe/codex-skills --list
```

安装指定 Skill：

```bash
npx skills add FelixLyfe/codex-skills \
  --skill migrate-uniapp-to-flutter \
  --agent codex \
  -g
```

安装仓库中的四份 Skill：

```bash
npx skills add FelixLyfe/codex-skills \
  --skill '*' \
  --agent codex \
  -g \
  -y
```

示例中的 `-g` 表示安装到用户级目录。只想在当前项目使用时，去掉 `-g`。

## devops-api-doc-to-code

用于从已登录的 API 文档页面或粘贴的契约文本中提取接口定义，并按任务需要完成只读审计或代码接入。

它有三种模式：

- `Extract`：整理接口路径、请求、响应、枚举、空值语义、错误和备注，不读取或修改业务代码。
- `Audit`：对照当前代码，给出 `change required`、`already compliant` 或 `blocked by a named gap`，保持工作区不变。
- `Implement`：先完成审计，再修改请求、模型、状态和 UI，并验证最终请求链路。

适合的输入包括已登录文档 URL、打开的浏览器标签页、接口正文，以及需要对照的代码仓库。私有文档无法通过浏览器读取时，也可以直接粘贴契约内容。

调用示例：

```text
使用 $devops-api-doc-to-code，以 Audit 模式对照这份 API 文档和当前代码，只报告差异，不修改文件。
```

```text
使用 $devops-api-doc-to-code，以 Implement 模式接入这份契约，并追踪到最终 HTTP 请求和页面状态。
```

## flutter-macos-env-setup

用于审查、搭建、修复或验收 Apple Silicon macOS 上的 Flutter iOS/Android 开发环境。它会先检查机器现状，再依据仓库固定的 FVM、Gradle、Android 和 Java 约束执行最小改动，并为每个阶段保留当前验证证据。

它有三个分支：

- `Audit`：只盘点和诊断环境，不修改配置或仓库。
- `Setup or repair`：只补齐目标工作流缺失或不兼容的组件。
- `Acceptance`：通过独立 Demo、固定版本项目、模拟器、真机或 Add-to-App 原生入口验证已有环境。

结果统一使用 `PASS`、`WARN`、`SKIP` 和 `FAIL`，并分开报告模拟器、项目构建、原生宿主、真机和在线服务证据。

调用示例：

```text
使用 $flutter-macos-env-setup 的 Audit 模式检查这台 Apple Silicon Mac 和当前 Flutter 仓库，只报告缺口，不修改配置。
```

```text
使用 $flutter-macos-env-setup 补齐 Flutter iOS/Android 环境，并分别在 iOS Simulator 和 Android Emulator 上跑通独立 Demo，再使用仓库固定的 FVM SDK 完成项目验证。
```

## migrate-uniapp-to-flutter

用于把 UniApp/Vue 页面迁移到 Flutter，或修复已经迁移页面的行为差异。检查范围限定在目标页面及其必要依赖。

它有三种模式：

- `Full migration`：迁移完整页面、状态、交互、接口和必要平台能力。
- `Parity repair`：只追踪并修复受影响的行为及依赖闭包。
- `Contract-drift audit`：只读比较 UniApp、当前 API/宿主契约和 Flutter，判断目标行为及偏差来源。

验证结果按 `code`、`build`、`host`、`live` 分开记录。Mock 只在需要离线复现、确定性业务状态或仓库已有 Mock/Real 边界时加入。

调用示例：

```text
使用 $migrate-uniapp-to-flutter，以 Full migration 模式把这个 UniApp 页面迁移到当前 Flutter 仓库，只包含页面和必要依赖。
```

```text
使用 $migrate-uniapp-to-flutter，以 Contract-drift audit 模式判断这个字段差异来自迁移遗漏还是后续契约变化，不修改代码。
```

## mastergo-to-uniapp-ui

用于把 MasterGo 图层或其他设计证据实现为 UniApp 小程序页面、组件，也可以修复运行时页面与设计稿之间的视觉和交互差异。

这份 Skill 会分别确认布局、文案、资源、交互和实现结构的权威来源。MasterGo 连接可用时读取图层数据；连接不可用时，可以使用截图、`UI.md`、`icon.md` 或当前运行页面作为证据。

按任务内容加载对应参考：设计提取、布局与路由、选择与表单、键盘与弹层、构建与运行时验证。具体项目名、固定路由和固定包管理器版本不会成为通用规则。

调用示例：

```text
使用 $mastergo-to-uniapp-ui，按照这个 MasterGo 图层实现当前 UniApp 页面，并在同一视口下对比运行结果。
```

```text
使用 $mastergo-to-uniapp-ui，修复截图中标出的间距、文字截断和弹层键盘问题，保持业务逻辑不变。
```

## 目录结构

```text
codex-skills/
├── README.md
├── README.zh-CN.md
├── devops-api-doc-to-code/
├── flutter-macos-env-setup/
├── migrate-uniapp-to-flutter/
└── mastergo-to-uniapp-ui/
```

每个 Skill 目录都包含 `SKILL.md`、`agents/openai.yaml`，并按工作流需要提供参考文件或确定性脚本。安装工具会扫描这些目录中的 `SKILL.md`。
