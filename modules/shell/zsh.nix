#
# Shell
#

{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;            # Auto suggest options and highlights syntax, searches in history for options
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;
      shellAliases = {
        ls = "exa -labg --git --color auto";
        cat = "bat";
        pb = "git branch --merged | grep -v -E \"main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)\" > /tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches";
        v = "nvim";
        fonts = "fc-list";
        gp = "git push origin HEAD 2>&1 | grep -o 'http[s]\?://[^\"]\+' | xargs git web--browse";
      };
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "git-extras" "docker" "docker-compose" "npm" "ripgrep"];
      };

      shellInit = ''
        if [ -f "$HOME/.feed-access-token" ]; then
          export FEED_ACCESSTOKEN=$(cat $HOME/.feed-access-token)
          export ENV DOTNET_SYSTEM_NET_HTTP_USESOCKETSHTTPHANDLER=0
          export VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{\"endpointCredentials\": [{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/NuAgile/_packaging/NudeSolutions/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.feed-access-token)\"},{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/ProjectVicious/_packaging/NudeGet/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.feed-access-token)\"}]}"
        fi

        if [ -f "$HOME/.openai-api-key" ]; then
          export OPENAI_API_KEY=$(cat $HOME/.openai-api-key)
        fi

        PATH="$PATH:$HOME/.local/bin"
        PATH="$PATH:$HOME/.dotfiles/bin"
        PATH="$PATH:/usr/share/dotnet"
        PATH="$PATH:$HOME/.dotnet/tools"

        HISTFILE=~/.zsh_history
        HISTSIZE=10000
        SAVEHIST=10000
        setopt APPEND_HISTORY
        setopt INC_APPEND_HISTORY
        setopt SHARE_HISTORY
        autoload -Uz compinit && compinit
      '';
    };
  };
}
