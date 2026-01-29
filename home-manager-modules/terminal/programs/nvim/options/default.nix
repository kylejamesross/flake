{pkgs, ...}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      have_nerd_font = true;
    };
    clipboard = {
      providers.wl-copy.enable = true;
      register = "unnamedplus";
    };
    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      shiftwidth = 2;
      tabstop = 2;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      breakindent = true;
      undofile = true;
      scrolloff = 10;
      signcolumn = "yes";
      incsearch = true;
      smartindent = true;
      updatetime = 250;
      timeoutlen = 500;
      splitright = true;
      splitbelow = true;
      cursorline = true;
      termguicolors = true;
      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
      shortmess = "I";
    };
    autoGroups = {
      kickstart-highlight-yank = {
        clear = true;
      };
    };
    autoCmd = [
      {
        event = ["TextYankPost"];
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback.__raw = ''
          function()
          vim.hl.on_yank()
          end
        '';
      }
    ];
    extraConfigLua =
      /*
      lua
      */
      ''
        vim.env.PATH = "${pkgs.nodejs_22}/bin:" .. vim.env.PATH

        local INTRO_NS = vim.api.nvim_create_namespace("intro_screen")
        vim.api.nvim_set_hl(0, "IntroEnter", { link = "SpecialKey" })

        local function center_block(raw, winid)
          local w = vim.api.nvim_win_get_width(winid)
          local h = vim.api.nvim_win_get_height(winid)

          local centered = {}
          for _, line in ipairs(raw) do
            if line == "" then
              centered[#centered + 1] = ""
            else
              local lw = vim.fn.strdisplaywidth(line)
              local pad = math.max(0, math.floor((w - lw) / 2))
              centered[#centered + 1] = string.rep(" ", pad) .. line
            end
          end

          local top_pad = math.max(0, math.floor((h - #centered) / 2))
          local out = {}
          for _ = 1, top_pad do
            out[#out + 1] = ""
          end
          vim.list_extend(out, centered)
          return out
        end

        local function highlight_enter(bufnr, lines)
          vim.api.nvim_buf_clear_namespace(bufnr, INTRO_NS, 0, -1)

          for lnum, line in ipairs(lines) do
            local from = 1
            while true do
              local s, e = line:find("<Enter>", from, true)
              if not s then
                break
              end
              vim.api.nvim_buf_add_highlight(bufnr, INTRO_NS, "IntroEnter", lnum - 1, s - 1, e)
              from = e + 1
            end
          end
        end

        local function ensure_intro_buffer()
          if vim.bo.filetype == "intro" then
            return
          end

          vim.cmd("enew")
          vim.bo.buftype = "nofile"
          vim.bo.bufhidden = "wipe"
          vim.bo.swapfile = false
          vim.bo.filetype = "intro"

          vim.wo.number = false
          vim.wo.relativenumber = false
          vim.wo.cursorline = false
          vim.wo.signcolumn = "no"
          vim.wo.wrap = false
        end

        local function render_intro()
          if vim.fn.argc() ~= 0 then
            return
          end
          ensure_intro_buffer()

          local v = vim.version()
          local ver_full = ("NVIM v%d.%d.%d"):format(v.major, v.minor, v.patch)
          local ver_mm = ("v%d.%d"):format(v.major, v.minor)

          local raw = {
            "",
            ver_full,
            "",
            "Nvim is open source and freely distributable",
            "https://neovim.io/#chat",
            "",
            "type  :help nvim<Enter>       if you are new!",
            "type  :checkhealth<Enter>     to optimize Nvim",
            "type  :q<Enter>               to exit",
            "type  :help<Enter>            for help",
            "",
            "type  :help news<Enter> to see changes in " .. ver_mm,
            "",
          }

          local lines = center_block(raw, 0)

          vim.bo.modifiable = true
          vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
          vim.bo.modifiable = false
          vim.bo.modified = false

          highlight_enter(0, lines)
        end

        local grp = vim.api.nvim_create_augroup("IntroScreen", { clear = true })

        vim.api.nvim_create_autocmd("VimEnter", {
          group = grp,
          once = true,
          callback = render_intro,
        })

        vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
          group = grp,
          callback = function()
            if vim.bo.filetype == "intro" then
              render_intro()
            end
          end,
        })
      '';
  };
}
