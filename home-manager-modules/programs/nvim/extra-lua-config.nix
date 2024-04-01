{ config, nixpkgs }: 

let
    colorUtils = import ./colors.nix { lib = nixpkgs.lib; };
in
    with colorUtils;
    with config.colorScheme.palette;
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
local status_ok, base16ColorScheme = pcall(require, "base16-colorscheme")
if not status_ok then
    return
        end

        base16ColorScheme.setup({
                base00 = '#${base00}', base01 = '#${base01}', base02 = '#${base02}', base03 = '#${base03}',
                base04 = '#${base04}', base05 = '#${base05}', base06 = '#${base06}', base07 = '#${base07}',
                base08 = '#${base08}', base09 = '#${base09}', base0A = '#${base0A}', base0B = '#${base0B}',
                base0C = '#${base0C}', base0D = '#${base0D}', base0E = '#${base0E}', base0F = '#${base0F}',
                });

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

