{
    programs.nixvim = {
        keymaps = [
        {
            mode = "n";
            key = "<Leader>rs";
            action = ":%s/\\<<C-r><C-w>\\>//g<Left><Left>";
            options = {
                noremap = true;
                silent = true;
                desc = "Replace all occurances of word under cursor in buffer";
            };
        }
        {
            mode = "n";
            key = "<Leader>dx";
            action = ":!chmod +x %<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Make file executeable";
            };
        }

        {
            mode = "v";
            key = "<Tab>";
            action = ">><Esc>gv";
            options = {
                noremap = true;
                silent = true;
                desc = "Increase Indent";
            };
        }
        {
            mode = "v";
            key = "<S-Tab>";
            action = "<<<Esc>gv";
            options = {
                noremap = true;
                silent = true;
                desc = "Descrease Indent";
            };
        }
        {
            mode = "i";
            key = "<M-k>";
            action = "<Up>";
            options = {
                noremap = true;
                silent = true;
                desc = "Move up";
            };
        }
        {
            mode = "i";
            key = "<M-j>";
            action = "<Down>";
            options = {
                noremap = true;
                silent = true;
                desc = "Move down";
            };
        }
        {
            mode = "i";
            key = "<M-l>";
            action = "<Right>";
            options = {
                noremap = true;
                silent = true;
                desc = "Move right";
            };
        }
        {
            mode = "i";
            key = "<M-h>";
            action = "<Left>";
            options = {
                noremap = true;
                silent = true;
                desc = "Move left";
            };
        }
        {
            mode = "v";
            key = "J";
            action = ":m '>+1<CR>gv=gv";
            options = {
                noremap = true;
                silent = true;
                desc = "Move line down";
            };
        }
        {
            mode = "v";
            key = "K";
            action = ":m '<-2<CR>gv=gv";
            options = {
                noremap = true;
                silent = true;
                desc = "Move line up";
            };
        }
        {
            mode = "x";
            key = "J";
            action = ":move '>+1<CR>gv-gv";
            options = {
                noremap = true;
                silent = true;
                desc = "Move line down";
            };
        }
        {
            mode = "x";
            key = "K";
            action = ":move '<-2<CR>gv-gv";
            options = {
                noremap = true;
                silent = true;
                desc = "Move line up";
            };
        }
        # {
        #     mode = "n";
        #     key = "<Leader>qq";
        #     action = ":cclose<CR>";
        #     options = {
        #         noremap = true;
        #         silent = true;
        #         desc = "Close quickfix list";
        #     };
        # }
        # {
        #     mode = "n";
        #     key = "<Leader>qo";
        #     action = ":copen<CR>";
        #     options = {
        #         noremap = true;
        #         silent = true;
        #         desc = "Open quickfix list";
        #     };
        # }
        {
            mode = "n";
            key = "<Leader>ll";
            action = ":lclose<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Close location list";
            };
        }
        {
            mode = "n";
            key = "<Leader>lo";
            action = ":lopen<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Open location list";
            };
        }
        {
            mode = "n";
            key = "]q";
            action = ":cnext<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Next quickfix list item";
            };
        }
        {
            mode = "n";
            key = "[q";
            action = ":cprev<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Previous quickfix list item";
            };
        }
        {
            mode = "n";
            key = "]l";
            action = ":lnext<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Next location list item";
            };
        }
        {
            mode = "n";
            key = "[l";
            action = ":lprev<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Previous location list item";
            };
        }
        {
            mode = "x";
            key = "<leader>p";
            action = ''"_dP'';
            options = {
                noremap = false;
                silent = true;
                desc = "Paste without replacing register";
            };
        }
        {
            mode = "n";
            key = "<C-Up>";
            action = ":resize +2<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Increase window size vertically";
            };
        }
        {
            mode = "n";
            key = "<C-Down>";
            action = ":resize -2<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Descrease window size vertically";
            };
        }
        {
            mode = "n";
            key = "<C-Left>";
            action = ":vertical resize +2<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Increase window size horizontally";
            };
        }
        {
            mode = "n";
            key = "<C-Right>";
            action = ":vertical resize -2<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Decrease window size horizontally";
            };
        }
        {
            mode = "n";
            key = "<M-l>";
            action = ":bnext<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Go to next buffer";
            };
        }
        {
            mode = "n";
            key = "<M-h>";
            action = ":bprevious<CR>";
            options = {
                noremap = true;
                silent = true;
                desc = "Go to previous buffer";
            };
        }
        {
            mode = "n";
            key = "n";
            action = "nzzzv";
            options = {
                desc = "Repeat search in same direction";
            };
        }
        {
            mode = "n";
            key = "N";
            action = "Nzzzv";
            options = {
                desc = "Repeat search in same direction";
            };
        }
        {
            mode = "n";
            key = "<C-d>";
            action = "<C-d>zz";
            options = {
                desc = "Move down half a page";
            };
        }
        {
            mode = "n";
            key = "<C-u>";
            action = "<C-u>zz";
            options = {
                desc = "Move up half a page";
            };
        }
        {
            mode = "n";
            key = "<Tab>";
            action = "<C-6>";
            options = {
                desc = "Switch to previous buffer";
            };
        }
        {
            mode = "n";
            key = "<Esc>";
            action = "<cmd>nohlsearch<CR>";
        }
        {
            mode = "n";
            key = "<C-h>";
            action = "<C-w><C-h>";
            options = {
                desc = "Move focus to the left window";
            };
        }
        {
            mode = "n";
            key = "<C-l>";
            action = "<C-w><C-l>";
            options = {
                desc = "Move focus to the right window";
            };
        }
        {
            mode = "n";
            key = "<C-j>";
            action = "<C-w><C-j>";
            options = {
                desc = "Move focus to the lower window";
            };
        }
        {
            mode = "n";
            key = "<C-k>";
            action = "<C-w><C-k>";
            options = {
                desc = "Move focus to the upper window";
            };
        }
        ];
    };
}