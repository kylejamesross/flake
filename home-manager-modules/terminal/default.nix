{ pkgs, lib, user, ... }:

{
    imports = [
        ./programs/zsh
        ./programs/tmux
        ./programs/nvim
        ./programs/btop
        ./programs/git
        ./programs/yazi
        ./programs/lazygit
        ./programs/tealdeer
        ./programs/bat
        ./scripts
    ];

    home = {
        packages = with pkgs; [
            sops
            gnutar
            unzip
            unrar
            zip
            tig
            shell-gpt
            gh
            ripgrep
            jaq
            fd
            eza
            du-dust
            nodejs
            bun
            yarn
            optipng
            fastfetch
            fzf
            nodePackages.ts-node
            nodePackages.typescript
            nodePackages.svgo
            zoxide
            docker-compose

            # work
            dotnet-sdk_8
            sqlcmd

            shellcheck
        ];

        activation.createHomeDirectories = lib.mkAfter ''
            mkdir -p /home/${user}/.ssh/
            mkdir -p /home/${user}/downloads/
        '';
        file.".ssh/id_ed25519.pub".source = ./files/id_ed25519.pub;
        file.".ssh/authorized_keys".source = ./files/id_ed25519.pub;
    };
}
