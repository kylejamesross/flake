{ pkgs, config, unstable, ... }:

with config.lib.stylix.colors;

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        dotDir = ".config/zsh";
        enableAutosuggestions = true;
        syntaxHighlighting = {
            enable = true;
            styles = {
                default = "none";
                unknown-token = "fg=#${base08},bold";
                reserved-word = "fg=#${base0A}";
                suffix-alias = "fg=#${base0B},underline";
                global-alias = "fg=#${base0C}";
                precommand = "fg=#${base0B},underline";
                commandseparator = "none";
                autodirectory = "fg=#${base0B},underline";
                path = "underline";
                path_pathseparator = "";
                path_prefix_pathseparator = "";
                globbing = "fg=#${base0D}";
                history-expansion = "fg=#${base0D}";
                command-substitution = "none";
                command-substitution-delimiter = "fg=#${base0E}";
                process-substitution = "none";
                process-substitution-delimiter = "fg=#${base0E}";
                single-hyphen-option = "none";
                double-hyphen-option = "none";
                back-quoted-argument = "none";
                back-quoted-argument-delimiter = "fg=#${base0E}";
                single-quoted-argument = "fg=#${base0A}";
                double-quoted-argument = "fg=#${base0A}";
                dollar-quoted-argument = "fg=#${base0A}";
                rc-quote = "fg=#${base0C}";
                dollar-double-quoted-argument = "fg=#${base0C}";
                back-double-quoted-argument = "fg=#${base0C}";
                back-dollar-quoted-argument = "fg=#${base0C}";
                assign = "none";
                redirection = "fg=#${base0A}";
                comment = "fg=#${base01},bold";
                named-fd = "none";
                numeric-fd = "none";
                arg0 = "fg=#${base0B}";
            };
        };
        history.size = 100000;
        shellAliases = {
            ls = "eza -bhal --icons --hyperlink --git --color auto";
            cat = "bat";
            pb = "git branch --merged | grep -v -E \"main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)\" > /tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches";
            n = "nvim";
            d7 = "nix shell nixpkgs#dotnet-sdk_7";
            fonts = "fc-list";
            wlogin = "az acr login -n nsolutionsacregistry";
            tsu = "sudo tailscale up --accept-routes";
            tsd = "sudo tailscale down";
            access-token = "az account get-access-token | jaq .accessToken | sed 's/\"//g' | wl-copy";
            g = "${unstable.nh}/bin/nh os switch";
            musb = '' mkdir -p ~/usb && sudo mount "/dev/$(lsblk --list | fzf | awk '{print $1}')" ~/usb '';
        };
        plugins = [
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
            {
                name = "powerlevel10k-config";
                src = ./p10k;
                file = ".p10k.zsh";
            }
            {
                name = "zsh-vi-mode";
                src = pkgs.zsh-vi-mode;
                file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
            }
        ];
        completionInit = '' 
                autoload -Uz compinit && compinit 
                eval "$(zoxide init zsh)"
        '';
        initExtra = ''
            if [ -f "$HOME/.feed-access-token" ]; then
              export FEED_ACCESSTOKEN=$(cat $HOME/.feed-access-token)
              export ENV DOTNET_SYSTEM_NET_HTTP_USESOCKETSHTTPHANDLER=0
              export VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{\"endpointCredentials\": [{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/NuAgile/_packaging/NudeSolutions/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.feed-access-token)\"},{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/ProjectVicious/_packaging/NudeGet/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.feed-access-token)\"}]}"
            fi

            if [ -f "$HOME/.openai-api-key" ]; then
              export OPENAI_API_KEY=$(cat $HOME/.openai-api-key)
            fi

            if [ -f "$HOME/.github-token" ]; then
              export GH_TOKEN=$(cat $HOME/.github-token)
            fi

            PATH="$PATH:$HOME/.local/bin"
            PATH="$PATH:/usr/share/dotnet"
            PATH="$PATH:$HOME/.dotnet/tools"
        '';
    };
}
