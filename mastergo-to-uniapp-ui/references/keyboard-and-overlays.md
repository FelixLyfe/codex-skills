# Keyboard and Overlays

Read this reference for popup focus, keyboard containment, pickers, native overlays, or chained prompts.

## Choose the Containment Strategy

Classify the active surface before sharing a keyboard fix:

- Native page viewport owns movement: use the platform's adjustment behavior when verified for that page.
- Internal scroll container owns movement: keep native adjustment disabled and manage focus/visibility inside the container.
- Plain CSS container owns scrolling: treat focus visibility as an explicit layout requirement rather than an automatic guarantee.

Keep the native input's ancestor geometry stable while focused. Evaluate scroll nesting, max-height changes, and spacers per container, then retain the variant verified on the target runtime.

## Focus Lifecycle

- Pass live visibility into children when an overlay remains mounted during leave animation.
- On close, clear focus state and hide the keyboard.
- Before opening media, file, or native pickers, clear focus and hide the keyboard.
- When listening for keyboard height, register and unregister the same function reference at lifecycle boundaries; define how zero and repeated heights affect layout.
- Timing delays are supporting mechanics, not acceptance evidence. Verify the resulting focus and geometry in DevTools or on a device.

## Overlay Ownership and Sequence

Classify overlay defects as copy, styling, stacking, or lifecycle before changing code. Native toast styling and stacking are platform-owned; use a page-owned overlay when the contract requires custom presentation or explicit ordering inside another container.

For chained business and native prompts, encode the accepted state sequence explicitly. A common sequence is:

1. complete the business operation;
2. close and settle the current surface;
3. open the native authorization/subscription prompt;
4. show result feedback;
5. refresh or navigate.

Preserve a different sequence when current evidence assigns it. Audit every caller before changing a shared success/prompt helper.

**Complete when:** open, focus, keyboard-open, picker transition, close/leave, and chained-prompt states have explicit transitions and applicable runtime evidence.
