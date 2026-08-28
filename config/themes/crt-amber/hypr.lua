-- IBM / DEC Mainframe Amber CRT Theme (Hyprland Lua)
hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 6,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(ff9e00ee)", "rgba(cc6600aa)"}, angle = 45 },
            inactive_border = "rgba(332000aa)",
        },
    },
    decoration = {
        rounding       = 0,
        rounding_power = 2,
        active_opacity   = 0.94,
        inactive_opacity = 0.85,
        shadow = {
            enabled      = true,
            range        = 18,
            render_power = 3,
            color        = 0xee110a00,
        },
        blur = {
            enabled   = true,
            size      = 6,
            passes    = 2,
            vibrancy  = 0.2,
        },
    },
})
