-- Apollo 1969 Flight Operations Theme (Hyprland Lua)
hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 8,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(ffb000ee)", "rgba(ff7b00bb)"}, angle = 45 },
            inactive_border = "rgba(283344aa)",
        },
    },
    decoration = {
        rounding       = 4,
        rounding_power = 2,
        active_opacity   = 0.98,
        inactive_opacity = 0.88,
        shadow = {
            enabled      = true,
            range        = 14,
            render_power = 3,
            color        = 0xee0e1116,
        },
        blur = {
            enabled   = true,
            size      = 5,
            passes    = 2,
            vibrancy  = 0.15,
        },
    },
})
