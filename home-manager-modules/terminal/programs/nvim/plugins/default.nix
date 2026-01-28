{pkgs, ...}: {
  imports = [
    ./blink-cmp
    ./code-companion
    ./conform
    ./dap
    ./gitsigns
    ./indent-blankline
    ./lint
    ./lsp
    ./mini
    ./neotest
    ./telescope
    ./treesitter
    ./which-key
  ];
  programs.nixvim = {
    plugins = {
      colorizer.enable = true;
      lspkind.enable = true;
      illuminate.enable = true;
      rainbow-delimiters.enable = true;
      ts-autotag.enable = true;
      markdown-preview.enable = true;
      web-devicons.enable = true;
      otter.enable = true;
      nvim-autopairs.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-textobj-entire
      omnisharp-extended-lsp-nvim
    ];
  };
}
