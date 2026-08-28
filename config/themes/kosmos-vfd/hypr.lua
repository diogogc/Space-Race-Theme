-- Soviet Kosmos VFD Theme (Hyprland Lua)
hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 8,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(48e5c2ee)", "rgba(33ffddaa)"}, angle = 45 },
            inactive_border = "rgba(1e4038aa)",
        },
    },
    decoration = {
        rounding       = 3,
        rounding_power = 2,
        active_opacity   = 0.96,
        inactive_opacity = 0.88,
        shadow = {
            enabled      = true,
            range        = 14,
            render_power = 3,
            color        = 0xee0d1a18,
        },
        blur = {
            enabled   = true,
            size      = 5,
            passes    = 2,
            vibrancy  = 0.18,
        },
    },
})
