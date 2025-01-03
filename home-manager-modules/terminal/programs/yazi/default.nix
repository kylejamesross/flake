{
  pkgs,
  inputs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        show_symlink = true;
        sort_dir_first = true;
      };
    };
    keymap = {
      manager.prepend_keymap = [
        {
          run = "shell '${pkgs.xdragon}/bin/xdragon -x -i -T \"$@\"' --confirm";
          on = ["g" "o"];
          desc = "Drag select files with Dragon";
        }
        {
          run = "shell '${pkgs.nodejs_22}/bin/npx svgo --multipass -i \"$1\" -o \"$1\"' --confirm";
          on = ["g" "v"];
          desc = "Optimize SVG file";
        }
        {
          on = ["g" "a"];
          run = "plugin compress";
          desc = "Archive selected files";
        }
        {
          on = ["g" "d"];
          run = "cd ~/downloads";
          desc = "Change directory to downloads";
        }
        {
          on = ["g" "s"];
          run = "cd ~/source";
          desc = "Change directory to source";
        }
        {
          on = ["g" "p"];
          run = "cd ~/personal";
          desc = "Change directory to personal";
        }
        {
          on = ["g" "b" "c"];
          run = "cd ~/source/base-components";
          desc = "Change directory to source/base-components";
        }
        {
          on = ["g" "b" "f"];
          run = "cd ~/source/base-functionality";
          desc = "Change directory to source/base-functionality";
        }
        {
          on = ["g" "g"];
          run = "cd ~/source/gateway-plus-front-end";
          desc = "Change directory to source/gateway-plus-front-end";
        }
      ];
    };
    plugins = {
      compress = "${inputs.yazi-compress-plugin}";
    };
  };
}
