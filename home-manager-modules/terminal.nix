{ pkgs, unstable, ... }:

{
    imports = [
        ./programs/zsh
        ./programs/tmux
        ./programs/nvim
        ./programs/btop
        ./programs/git
        ./programs/lazygit
        ./programs/swappy
        ./programs/tealdeer
        ./services/nextcloud-autosync
        ./scripts
    ];

    home = {
        packages = with pkgs; [
            sops
            gnutar
            unzip
            unrar
            zip
            yazi
            tig
            shell_gpt
            gh
            ripgrep
            jaq
            fd
            eza
            bat
            du-dust
            nodejs_20
            bun
            yarn
            optipng
            neofetch
            fzf
            nodePackages.typescript
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
            rust-analyzer
            lua-language-server
            cargo
            rustc
            rustfmt
            omnisharp-roslyn
            nil

            # debug adapters
            netcoredbg
            lldb
            vscode-extensions.vadimcn.vscode-lldb
        ];

        file.".ssh/id_ed25519.pub".source = ./files/id_ed25519.pub;
        file.".ssh/authorized_keys".source = ./files/id_ed25519.pub;
    };
}
