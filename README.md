# Feather HUD

> The official player HUD for the Feather Framework — an always-on Resource Strip showing cash, gold, tokens, and XP/rank.

## Screenshots

<!-- Add screenshots here, e.g.: -->
<!-- ![Resource Strip](./screenshots/resource-strip.png) -->

## Features

- Always-on Resource Strip: cash, gold, tokens, and an XP/rank bar with a level shield
- No interaction, no screen real estate taken up by a panel — legible over any background, never blocks mouse or camera input
- Configurable anchor position (all 8 screen corners/edges/sides), padding, scale, and an optional legibility scrim
- Updates live as a player's economy changes — no menu to open, no manual refresh

## Requirements

- RedM server with `fx_version` `cerulean` or newer
- Lua 5.4 (`lua54 'yes'` is set in the manifest)
- [`feather-core`](https://github.com/FeatherFramework/feather-core) — feather-hud reads character/economy data
  through it and has no data of its own

## Installation

1. Download `feather-hud.zip` from [releases/latest](https://github.com/DavFount/feather-hud/releases/latest)
2. Extract and place the `feather-hud` folder into your server's `resources` directory
3. Add `ensure feather-hud` to your `server.cfg` (after `feather-core`)
4. Restart the server or start the resource with `start feather-hud`

## Configuration

All settings live in `config.lua`. Positioning uses a `HudPosition` table of named constants instead of raw text,
so there's no risk of a typo silently breaking the layout:

```lua
Config.ResourceStrip = {
    anchor  = HudPosition.BottomRight, -- HudPosition.TopLeft, .TopCenter, .TopRight,
                                        -- .MiddleLeft, .MiddleRight,
                                        -- .BottomLeft, .BottomCenter, .BottomRight
    padding = 26,   -- Distance in pixels from the screen edge the strip is anchored to
    scale   = 1.0,  -- Uniform size multiplier -- 1.0 is normal size, 1.2 is 20% bigger, 0.8 is 20% smaller
    scrim   = true  -- Soft dark backdrop behind the text so it stays readable over bright backgrounds
}
```

An unrecognized `anchor` value falls back to `HudPosition.BottomRight` automatically.

## Development

The NUI is a Vue 3 + Vite app in `ui/`:

```bash
cd ui
pnpm install
pnpm build   # outputs to ui/dist -- see below for how it gets deployed
pnpm dev     # live dev server for UI iteration
pnpm lint
```

`fxmanifest.lua` points at `ui/index.html` and `ui/assets/*.*` directly (not `ui/dist/`) — the release workflow's
zip step flattens `ui/dist/`'s contents up one level to match. When testing a local build without going through a
release, copy `ui/dist/`'s *contents* (not the folder itself) into `ui/` — `dist/index.html` → `ui/index.html`,
`dist/assets/*` → `ui/assets/*`.

## Troubleshooting

If you encounter any issues or have questions, post in our [discord](https://discord.gg/zBCPbPJGZw) bugs and
support channel. You may also open an issue on the issue tracker tab of GitHub.

## Contributing

Contributions to any of our Feather scripts are welcome! If you have improvements or bug fixes, feel free to
submit a pull request.
