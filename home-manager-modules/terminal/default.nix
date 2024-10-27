{
  pkgs,
  lib,
  user,
  ...
}: {
  imports = [
    ./programs/fish
    ./programs/tmux
    ./programs/nvim
    ./programs/git
    ./programs/yazi
    ./programs/lazygit
    ./programs/tealdeer
    ./programs/direnv
    ./scripts
  ];

  programs = {
    starship.enable = true;
    zoxide.enable = true;
    bat.enable = true;
    eza.enable = true;
    btop.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
    fastfetch.enable = true;
  };

  home = {
    packages = with pkgs; [
      sops
      gnutar
      unzip
      unrar
      zip
      tig
      shell-gpt
      jaq
      du-dust
      optipng
      nodePackages.svgo
      docker-compose
    ];

    activation.createHomeDirectories = lib.mkAfter ''
      mkdir -p /home/${user}/.ssh/
      mkdir -p /home/${user}/downloads/
    '';
    file.".ssh/id_ed25519.pub".source = ./files/id_ed25519.pub;
    file.".ssh/authorized_keys".source = ./files/id_ed25519.pub;
  };
}
