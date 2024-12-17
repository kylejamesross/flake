{pkgs, ...}: {
  imports = [
    ./telescope
    ./mini
    ./lsp
    ./cmp
    ./which-key
    ./treesitter
    ./autopairs
    ./chatgpt
    ./gitsigns
    ./conform
    ./indent-blankline
    ./neotest
  ];
  programs.nixvim = {
    plugins = {
      nvim-colorizer.enable = true;
      lspkind.enable = true;
      illuminate.enable = true;
      rainbow-delimiters.enable = true;
      ts-autotag.enable = true;
      markdown-preview.enable = true;
      web-devicons.enable = true;
      otter.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-textobj-entire
    ];
  };
}
