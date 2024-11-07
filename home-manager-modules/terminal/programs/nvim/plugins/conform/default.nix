{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    extraConfigLua = ''
      vim.api.nvim_create_user_command("FormatDisable", function(args)
         if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          -- Toggle formatting for current buffer
          vim.b.disable_autoformat = not vim.b.disable_autoformat
        else
          -- Toggle formatting globally
          vim.g.disable_autoformat = not vim.g.disable_autoformat
        end
      end, {
        desc = "Toggle autoformat-on-save",
        bang = true,
      })
    '';
    plugins.conform-nvim = {
      enable = true;
      notifyOnError = true;
      formatOnSave = ''
        function(bufnr)
            local disable_filetypes = { c = true, cpp = true }
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype]
            }
        end
      '';
      formattersByFt = {
        html = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        css = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascriptreact = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        typescript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        typescriptreact = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        lua = ["stylua"];
        nix = ["alejandra"];
        markdown = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        yaml = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        bash = [
          "shellcheck"
          "shellharden"
          "shfmt"
        ];
        json = ["jq"];
      };

      formatters = {
        alejandra = {
          command = "${lib.getExe pkgs.alejandra}";
        };
        jq = {
          command = "${lib.getExe pkgs.jq}";
        };
        prettierd = {
          command = "${lib.getExe pkgs.prettierd}";
        };
        stylua = {
          command = "${lib.getExe pkgs.stylua}";
        };
        shellcheck = {
          command = "${lib.getExe pkgs.shellcheck}";
        };
        shfmt = {
          command = "${lib.getExe pkgs.shfmt}";
        };
        shellharden = {
          command = "${lib.getExe pkgs.shellharden}";
        };
      };
    };
    keymaps = [
      {
        mode = "";
        key = "<leader>rf";
        action.__raw = ''
              function()
              require('conform').format { async = true, lsp_fallback = true }
          end
        '';
        options = {desc = "LSP: [F]ormat";};
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = ":FormatToggle<CR>";
        options = {
          desc = "[T]oggle [F]ormat";
          silent = true;
        };
      }
    ];
  };
}
