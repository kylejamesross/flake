{ config, nixpkgs }: 

let
    colorUtils = import ./colors.nix { lib = nixpkgs.lib; };
in
    with colorUtils;
    with config.lib.stylix.colors;
let
    percent = -70;
    darkRed = shadeColor { color = base08; percent = percent; };
    darkYellow = shadeColor { color = base0A; percent = percent; };
    darkBlue = shadeColor { color = base0D; percent = percent; };
    darkOrange = shadeColor { color = base09; percent = percent; };
    darkGreen = shadeColor { color = base0B; percent = percent; };
    darkPurple = shadeColor { color = base0E; percent = percent; };
    darkCyan = shadeColor { color = base0C; percent = percent; };
in
''
local status_ok, indentBlankline = pcall(require, "ibl")

if not status_ok then
    return
        end

        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

local hooks = require "ibl.hooks"

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#${darkRed}"})
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#${darkYellow}" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#${darkBlue}" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#${darkOrange}" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#${darkGreen}" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#${darkPurple}" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#${darkCyan}" })
        end)

indentBlankline.setup { indent = { highlight = highlight } }
''

