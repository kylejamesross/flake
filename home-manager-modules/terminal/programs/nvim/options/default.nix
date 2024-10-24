{
  programs.nixvim = {
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
      timeoutlen = 100;
      splitright = true;
      splitbelow = true;
      clipboard = "unnamedplus";
      cursorline = true;
      termguicolors = true;
      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
    };
    autoGroups = {
      kickstart-highlight-yank = {
        clear = true;
      };
    };
    globals.mapleader = " ";
    autoCmd = [
      {
        event = ["TextYankPost"];
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback.__raw = ''
          function()
          vim.highlight.on_yank()
          end
        '';
      }
    ];
  };
}
