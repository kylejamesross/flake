{
  pkgs,
  lib,
  user,
  inputs,
  system,
  ...
}: {
  imports = [
    ./programs/direnv
    ./programs/fish
    ./programs/git
    ./programs/lazygit
    ./programs/nvim
    ./programs/tmux
    ./programs/yazi
    ./scripts
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    fzf.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    tealdeer.enable = true;
    zoxide.enable = true;
  };

  home = {
    packages = with pkgs; [
      abcde
      aichat
      du-dust
      ffmpeg
      imagemagick
      p7zip
      poppler
      sops
      tig
      inputs.astal.packages.${system}.default
    ];

    activation.createHomeDirectories = lib.mkAfter ''
      mkdir -p /home/${user}/.ssh/
      mkdir -p /home/${user}/downloads/
    '';
    file.".ssh/id_ed25519.pub".source = ./files/id_ed25519.pub;
    file.".ssh/authorized_keys".source = ./files/id_ed25519.pub;
  };
}
