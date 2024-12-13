{
  pkgs,
  inputs,
  ...
}: {
  programs.nixvim = {
    /*
    git_file_history dep
    */
    plugins.fugitive.enable = true;

    extraPlugins = [
      pkgs.vimPlugins.telescope-undo-nvim
      (pkgs.vimUtils.buildVimPlugin {
        name = "telescope-git-file-history.nvim";
        src = inputs.telescope-git-file-history-nvim;
      })
    ];

    plugins.telescope = {
      enable = true;

      enabledExtensions = ["git_file_history"];

      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };

      keymaps = {
        "<leader>sh" = {
          mode = "n";
          action = "help_tags";
          options = {
            desc = "[S]earch [H]elp";
          };
        };
        "<leader>sk" = {
          mode = "n";
          action = "keymaps";
          options = {
            desc = "[S]earch [K]eymaps";
          };
        };
        "<leader>ss" = {
          mode = "n";
          action = "builtin";
          options = {
            desc = "[S]earch [S]elect Telescope";
          };
        };
        "<leader>sw" = {
          mode = "n";
          action = "grep_string";
          options = {
            desc = "[S]earch current [W]ord";
          };
        };
        "<leader>sg" = {
          mode = "n";
          action = "live_grep";
          options = {
            desc = "[S]earch by [G]rep";
          };
        };
        "<leader>sd" = {
          mode = "n";
          action = "diagnostics";
          options = {
            desc = "[S]earch [D]iagnostics";
          };
        };
        "<leader>sr" = {
          mode = "n";
          action = "resume";
          options = {
            desc = "[S]earch [R]esume";
          };
        };
        "<leader>so" = {
          mode = "n";
          action = "oldfiles";
          options = {
            desc = "[S]earch Old Files";
          };
        };
        "<leader>sc" = {
          mode = "n";
          action = "git_file_history";
          options = {
            desc = "[S]earch Buffer [C]ommit History";
          };
        };
        "<leader>sb" = {
          mode = "n";
          action = "buffers";
          options = {
            desc = "[S]earch Existing [B]uffers";
          };
        };
      };
      settings = {
        extensions.__raw = "{ ['ui-select'] = { require('telescope.themes').get_dropdown() } }";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<c-p>";
        action.__raw = ''
          function()
            require('telescope.builtin').find_files {
              hidden = true
            }
          end
        '';
        options = {
          desc = "[S]earch [F]iles";
        };
      }
      {
        mode = "n";
        key = "<leader>sf";
        action.__raw = ''
              function()
              require('telescope.builtin').find_files {
                  hidden = true
              }
          end
        '';
        options = {
          desc = "[S]earch [F]iles";
        };
      }
      {
        mode = "n";
        key = "<c-t>";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>sy";
        action.__raw = ''
          function()
            require('telescope.builtin').current_buffer_fuzzy_find(
              require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false
              }
            )
          end
        '';
        options = {
          desc = "[S]earch Fuzzil[y] in current buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>sn";
        action.__raw = ''
          function()
            require('telescope.builtin').find_files {
              cwd = vim.fn.stdpath 'config'
            }
          end
        '';
        options = {
          desc = "[S]earch [N]eovim files";
        };
      }
    ];
  };
}
