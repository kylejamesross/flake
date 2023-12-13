{ pkgs, config, ... }:

{
  programs.lf = {
    enable = true;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
      ''${{
        printf "Directory Name: "
        read DIR
        mkdir $DIR
      }}
      '';
      mkfile = ''
      ''${{
        printf "File Name: "
        read ans
        touch $ans
      }}
      '';
      extract = ''
      ''${{
        set -f
        case $f in
            *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar xjvf $f;;
            *.tar.gz|*.tgz) tar xzvf $f;;
            *.tar.xz|*.txz) tar xJvf $f;;
            *.zip) unzip $f;;
            *.rar) unrar x $f;;
            *.7z) 7z x $f;;
        esac
      }}
      '';
    };
    keybindings = {
      "\\\"" = "";
      o = "&mimeopen $f";
      c = "mkdir";
      "." = "set hidden!";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";
      do = "dragon-out";
      "g~" = "cd";
      gh = "cd";
      "g/" = "/";
      ee = "editor-open";
      V = ''$${pkgs.bat}/bin/bat --paging=always "$f"'';
      gd = "cd ~/Downloads";
      gf = "cd ~/flake";
      gs = "cd ~/source";
      gbc = "cd ~/source/base-components";
      gbf = "cd ~/source/base-functionality";
      gc = "cd ~/source/connex-front-end";
      gx = "extract";
      mk = "mkfile";
      R = "reload";
    };
    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
    extraConfig = 
    let 
      previewer = 
        pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5
        
        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
        fi
        
        ${pkgs.pistol}/bin/pistol "$file"
      '';
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';
    in
    ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
    '';
  };
}
