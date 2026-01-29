{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
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
              openai.__raw = ''
                function()
                  return require("codecompanion.adapters").extend("openai", {
                    schema = { model = { default = "gpt-5-mini" } }
                  })
                end
              '';
            };
          };

          strategies = {
            agent.adapter = "openai";
            chat.adapter = "openai";
            inline.adapter = "openai";
          };

          inline.enable = true;
        };
      };
      fidget.enable = true;
    };

    extraPackages = with pkgs; [
      file
      curl
      ripgrep
      vimPlugins.plenary-nvim
    ];

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

    autoGroups = {
      CodeCompanionFidgetHooks = {clear = true;};
    };

    autoCmd = [
      {
        event = ["User"];
        pattern = "CodeCompanionRequestStarted";
        group = "CodeCompanionFidgetHooks";
        callback.__raw = ''
          function(request)
            local progress = require("fidget.progress")
            _G.__cc_fidget_handles = _G.__cc_fidget_handles or {}

            local function llm_role_title(adapter)
              local parts = { adapter.formatted_name }
              if adapter.model and adapter.model ~= "" then
                table.insert(parts, "(" .. adapter.model .. ")")
              end
              return table.concat(parts, " ")
            end

            local handle = progress.handle.create({
              title = " Requesting assistance (" .. request.data.strategy .. ")",
              message = "In progress...",
              lsp_client = { name = llm_role_title(request.data.adapter) },
            })

            _G.__cc_fidget_handles[request.data.id] = handle
          end
        '';
      }

      {
        event = ["User"];
        pattern = "CodeCompanionRequestFinished";
        group = "CodeCompanionFidgetHooks";
        callback.__raw = ''
          function(request)
            _G.__cc_fidget_handles = _G.__cc_fidget_handles or {}
            local handle = _G.__cc_fidget_handles[request.data.id]
            _G.__cc_fidget_handles[request.data.id] = nil
            if not handle then return end

            if request.data.status == "success" then
              handle.message = "Completed"

              handle.message = " Error"
            else
              handle.message = "󰜺 Cancelled"
            end

            handle:finish()
          end
        '';
      }
    ];
  };
}
