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
        undo.enable = true;
      };

      keymaps = {
        "<leader>sh" = {
          mode = "n";
          action = "help_tags";
          options = {
            desc = "Search [H]elp";
          };
        };
        "<leader>sk" = {
          mode = "n";
          action = "keymaps";
          options = {
            desc = "Search [K]eymaps";
          };
        };
        "<leader>ss" = {
          mode = "n";
          action = "builtin";
          options = {
            desc = "Search Builtins";
          };
        };
        "<leader>sw" = {
          mode = "n";
          action = "grep_string";
          options = {
            desc = "Search [W]ord";
          };
        };
        "<leader>sg" = {
          mode = "n";
          action = "live_grep";
          options = {
            desc = "Search by [G]rep";
          };
        };
        "<leader>sd" = {
          mode = "n";
          action = "diagnostics";
          options = {
            desc = "Search [D]iagnostics";
          };
        };
        "<leader>sr" = {
          mode = "n";
          action = "resume";
          options = {
            desc = "Search [R]esume";
          };
        };
        "<leader>so" = {
          mode = "n";
          action = "oldfiles";
          options = {
            desc = "Search Old Files";
          };
        };
        "<leader>sc" = {
          mode = "n";
          action = "git_file_history";
          options = {
            desc = "Search Buffer [C]ommit History";
          };
        };
        "<leader>sb" = {
          mode = "n";
          action = "buffers";
          options = {
            desc = "Search Existing [B]uffers";
          };
        };
        "<leader>su" = {
          mode = "n";
          action = "undo";
          options = {
            desc = "Search [U]ndo Tree";
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
          desc = "Search [F]iles";
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
          desc = "Search [F]iles";
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
          desc = "Search Fuzzil[y] in current buffer";
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
          desc = "Search [N]eovim files";
        };
      }
    ];
  };
}
