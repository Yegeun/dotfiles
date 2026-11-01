# Global instructions (apply to every project)

## Web / front-end development checklist

### Modals, popups, dialogs, drawers, bottom sheets
When building or editing any overlay component, always:

- **Lock background scroll while it's open.** Set `document.body.style.overflow = 'hidden'` on
  open and restore the original value on close (compensate for scrollbar width with
  `padding-right` to avoid layout shift). Without this, on mobile a touch-drag scrolls the page
  behind the overlay instead of the overlay content — the most common and awkward mobile bug.
- **Make the overlay itself scrollable when its content can exceed the viewport.** Put
  `overflow-y-auto` on the fixed full-screen container and center the panel with a
  `flex min-h-full items-center justify-center` wrapper (not `items-center` on the fixed element
  directly, and not `overflow-hidden` on the panel). Otherwise tall content is clipped with no
  way to reach the top/bottom on small screens.
- **Stop scroll chaining** to the page with `overscroll-contain` (Tailwind) / `overscroll-behavior: contain`.
- Close on Escape and on backdrop click; keep `role="dialog"` + `aria-modal="true"`.

### General mobile hygiene
- Test layouts at ~375px width and with the on-screen keyboard open (it shrinks the viewport).
- Prefer `min-h-dvh`/`dvh` units over `vh` where mobile browser chrome matters.
- Ensure tap targets are ≥ 44px and inputs use appropriate `type`/`inputmode`.
