{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      nui.enable = true;
      codecompanion = {
        enable = true;
        settings = {
          adapters = {
            http = {
              opts = {
                log_level = "TRACE";
                send_code = true;
                use_default_actions = true;
                use_default_prompts = true;
              };
              openai = {
                __raw = ''
                  function()
                    return require("codecompanion.adapters").extend("openai", {
                      schema = {
                        model = {
                          default = "gpt-5-mini"
                        }
                      }
                    })
                  end
                '';
              };
            };
          };
          strategies = {
            agent = {
              adapter = "openai";
            };
            chat = {
              adapter = "openai";
            };
            inline = {
              adapter = "openai";
            };
          };
          inline = {
            enable = true;
            ui = {
              show_indicator = true;
              indicator_text = "⏳";
            };
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>cc";
        action = "<cmd>CodeCompanionChat<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "[C]odeCompanion: [C]hat";
        };
      }
      {
        mode = "n";
        key = "<leader>tc";
        action = "<cmd>CodeCompanionChat Toggle<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "[T]oggle [C]odeCompanion Chat";
        };
      }
    ];
    extraPackages = with pkgs; [
      file
      vimPlugins.plenary-nvim
    ];
  };
}
