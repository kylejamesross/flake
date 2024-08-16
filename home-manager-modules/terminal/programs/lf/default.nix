{ pkgs, ... }:

{
    xdg.configFile."lf/icons".source = ./icons;

    programs.lf = {
        enable = true;
        commands = {
            delete = ''
                ''${{
                    set -f
                    printf "$fx\n"
                    printf "delete?[y/n]"
                    read ans
                    [ "$ans" = "y" ] && rm -rf $fx
                }}
            '';
            mkdir = ''
                ''${{
                    printf "Directory Name: "
                    read DIR
                    mkdir $DIR
                }}
            '';
            extract = ''
                ''${{
                    set -f
                    case $f in
                        *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) ${pkgs.gnutar}/bin/tar xjvf $f;;
                        *.tar.gz|*.tgz) ${pkgs.gnutar}/bin/tar xzvf $f;;
                        *.tar.xz|*.txz) ${pkgs.gnutar}/bin/tar xJvf $f;;
                        *.zip) ${pkgs.unzip}/bin/unzip $f;;
                        *.rar) ${pkgs.unrar}/bin/unrar x $f;;
                        *.7z) ${pkgs.p7zip}/bin/7z x $f;;
                    esac
                }}
            '';
            optimize_svg = ''
                ''${{
                    ${pkgs.nodePackages.svgo}/bin/svgo --multipass -i "$f" -o "$f"
                }}
            '';
            extractIntoFolder = ''
                ''${{
                    set -f
                    base=''$(basename "$f")
                    dir="''${base%.*}"
                    mkdir -p "$dir"
                    case $f in
                        *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) ${pkgs.gnutar}/bin/tar xjvf "$f" -C "$dir";;
                        *.tar.gz|*.tgz) ${pkgs.gnutar}/bin/tar xzvf "$f" -C "$dir";;
                        *.tar.xz|*.txz) ${pkgs.gnutar}/bin/tar xJvf "$f" -C "$dir";;
                        *.zip) ${pkgs.unzip}/bin/unzip "$f" -d "$dir";;
                        *.rar) ${pkgs.unrar}/bin/unrar x "$f" "$dir";;
                        *.7z) ${pkgs.p7zip}/bin/7z x "$f" -o"$dir";;
                        *) ${pkgs.unzip}/bin/unzip "$f" -d "$dir";;
                    esac
                }}
            '';
            tar = ''
                ''${{
                    set -f
                    mkdir $1
                    cp -r $fx $1
                    ${pkgs.gnutar}/bin/tar czf $1.tar.gz $1
                    rm -rf $1
                }}
            '';
            zip = ''
                ''${{
                    set -f
                    mkdir $1
                    cp -r $fx $1
                    zip -r $1.zip $1
                    rm -rf $1
                }}
            '';
            rename = ''%[ -e $1 ] && printf "file exists" || mv $f $1 '';
            fzf =  ''
                ''${{
                    res="$(find . -maxdepth 1 | ${pkgs.fzf}/bin/fzf --reverse --header='Jump to location')"
                    if [ -n "$res" ]; then
                        if [ -d "$res" ]; then
                            cmd="cd"
                        else
                            cmd="select"
                        fi
                        res="$(printf '%s' "$res" | sed 's/\\/\\\\/g;s/"/\\"/g')"
                        lf -remote "send $id $cmd \"$res\""
                    fi
                }}'';
            dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
        };

        keybindings = {
            "\\\"" = "";
            o = "";
            a = "push %mkdir<space>";
            A = "push %touch<space>";
            r = "push :rename<space>";
            R = "reload";
            "<enter>" = "open";
            "." = "set hidden!";
            D = "delete";
            p = "paste; clear";
            gx = "extractIntoFolder";
            gX = "extract";
            gt = "tar";
            gz = "zip";
            gv = "optimize_svg";
            "g~" = "cd ~";
            gd = "cd ~/downloads";
            gs = "cd ~/source";
            gp = "cd ~/personal";
            gbc = "cd ~/source/base-components";
            gbf = "cd ~/source/base-functionality";
            go = "dragon-out";
        };

        settings = {
            preview = true;
            hidden = true;
            drawbox = true;
            icons = true;
            ignorecase = true;
            scrolloff = 10;
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

# ...
}
