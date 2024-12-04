{...}: {
  imports = [
    ./options
    ./keymaps
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
