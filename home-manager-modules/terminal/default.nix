{
  pkgs,
  lib,
  inputs,
  system,
  ...
}: {
  imports = [
    ./programs/aider
    ./programs/direnv
    ./programs/fish
    ./programs/git
    ./programs/lazygit
    ./programs/nixvim
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
    bash.enable = true;
  };

  home = {
    packages = with pkgs; [
      abcde
      aichat
      dust
      ffmpeg
      imagemagick
      meld
      p7zip
      pi-coding-agent
      poppler
      sops
      tig
      samba
      inputs.astal.packages.${system}.default
    ];

    activation.createHomeDirectories = lib.mkAfter ''
      mkdir -p "$HOME/.ssh"
      mkdir -p "$HOME/downloads"
    '';
    file.".ssh/id_ed25519.pub".source = ./files/id_ed25519.pub;
    file.".ssh/authorized_keys".source = ./files/id_ed25519.pub;
  };
}
