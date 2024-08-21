{ pkgs, unstable, lib, user, ... }:

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
            nodejs_20
            bun
            yarn
            optipng
            fastfetch
            fzf
            nodePackages.typescript
            nodePackages.eslint
            nodePackages.svgo
            zoxide
            docker-compose

            # work
            powershell
            unstable.dotnet-sdk_8
            sqlcmd

            # lsp
            nodePackages.typescript-language-server
            nodePackages.vscode-langservers-extracted
            nodePackages."@astrojs/language-server"
            nodePackages."bash-language-server"
            rust-analyzer
            lua-language-server
            cargo
            rustc
            rustfmt
            omnisharp-roslyn
            nil
            shellcheck

            # debug adapters
            netcoredbg
            lldb
            vscode-extensions.vadimcn.vscode-lldb
        ];

        activation.createHomeDirectories = lib.mkAfter ''
            mkdir -p /home/${user}/.ssh/
            mkdir -p /home/${user}/downloads/
            mkdir -p /home/${user}/.nuget/plugins/netcore
        '';
        file.".ssh/id_ed25519.pub".source = ./files/id_ed25519.pub;
        file.".ssh/authorized_keys".source = ./files/id_ed25519.pub;
        file.".nuget/plugins/netcore/CredentialProvider.Microsoft" = {
            source = ./files/CredentialProvider.Microsoft;
            recursive = true;
        };
    };
}
