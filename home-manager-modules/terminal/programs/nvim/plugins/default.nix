{ pkgs, ... }: {
  imports = [
    ./telescope
    ./mini
    ./lsp
    ./cmp
    ./which-key
    ./treesitter
    ./autopairs
    ./chatgpt
    ./none-ls
    ./gitsigns
    ./conform
  ];
  programs.nixvim = {
    plugins = {
      sleuth.enable = true;
      indent-blankline.enable = true;
      comment.enable = true;
      nvim-colorizer.enable = true;
      lspkind.enable = true;
      illuminate.enable = true;
      rainbow-delimiters.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-textobj-entire
      omnisharp-extended-lsp-nvim
      typescript-nvim
    ];

    extraConfigLua = "";
  };
}
