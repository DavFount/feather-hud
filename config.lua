Config = {}

-- HudPosition: the 8 places the cash/gold/tokens/XP strip can appear on
-- screen. To change where it shows up, edit Config.ResourceStrip.anchor
-- below and set it to ONE of these -- e.g. HudPosition.TopLeft.
-- Do NOT type a position in by hand as plain text (like "top-left") --
-- always use HudPosition.SomethingHere exactly as spelled here, or it will
-- be ignored and silently fall back to the bottom-right default.
HudPosition = {
    TopLeft      = 'top-left',
    TopCenter    = 'top-center',
    TopRight     = 'top-right',
    MiddleLeft   = 'middle-left',
    MiddleRight  = 'middle-right',
    BottomLeft   = 'bottom-left',
    BottomCenter = 'bottom-center',
    BottomRight  = 'bottom-right'
}

Config.ResourceStrip = {
    anchor  = HudPosition.TopRight, -- Where the strip appears. Must be one of the HudPosition.* values above.
    padding = 26,                   -- Distance in pixels from the screen edge the strip is anchored to.
    scale   = 1.0,                  -- Uniform size multiplier -- 1.0 is normal size, 1.2 is 20% bigger, 0.8 is 20% smaller.
    scrim   = true                  -- Soft dark backdrop behind the text so it stays readable over bright backgrounds. Set to false to disable it.
}
