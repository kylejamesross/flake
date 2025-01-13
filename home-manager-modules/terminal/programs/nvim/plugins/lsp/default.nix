{...}: {
  imports = [
    ./servers/ts_ls
    ./servers/omnisharp
    ./servers/lua_ls
  ];
  programs.nixvim = {
    plugins = {
      cmp-nvim-lsp.enable = true;
      fidget.enable = true;
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          cssls.enable = true;
          bashls.enable = true;
          eslint.enable = true;
          jsonls.enable = true;
          astro.enable = true;
        };

        keymaps = {
          diagnostic = {
            "<leader>lq" = {
              action = "setloclist";
              desc = "Open diagnostic [Q]uickfix list";
            };
          };

          extra = [
            {
              mode = "n";
              key = "K";
              action.__raw = "vim.lsp.buf.hover";
              options = {
                desc = "LSP: [G]o to [D]efinition";
              };
            }
            {
              mode = "n";
              key = "gf";
              action.__raw = "vim.diagnostic.open_float";
              options = {
                desc = "[G]o to diagnostic float";
              };
            }
            {
              mode = "n";
              key = "gd";
              action.__raw = "require('telescope.builtin').lsp_definitions";
              options = {
                desc = "LSP: [G]oto [D]efinition";
              };
            }
            {
              mode = "n";
              key = "gr";
              action.__raw = "require('telescope.builtin').lsp_references";
              options = {
                desc = "LSP: [G]o to [R]eferences";
              };
            }
            {
              mode = "n";
              key = "gi";
              action.__raw = "require('telescope.builtin').lsp_implementations";
              options = {
                desc = "LSP: [G]o to [I]mplementation";
              };
            }
            {
              mode = "n";
              key = "<leader>ld";
              action.__raw = "require('telescope.builtin').lsp_type_definitions";
              options = {
                desc = "Type [D]efinition";
              };
            }
            {
              mode = "n";
              key = "<leader>ls";
              action.__raw = "require('telescope.builtin').lsp_document_symbols";
              options = {
                desc = "Document [S]ymbols";
              };
            }
            {
              mode = "n";
              key = "<leader>lw";
              action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
              options = {
                desc = "[W]orkspace Symbols";
              };
            }
            {
              mode = "n";
              key = "]d";
              action.__raw = "vim.diagnostic.goto_next";
              options = {
                desc = "Go to next [D]iagnostic message";
              };
            }
            {
              mode = "n";
              key = "[d";
              action.__raw = "vim.diagnostic.goto_prev";
              options = {
                desc = "Go to previous [D]iagnostic message";
              };
            }
            {
              mode = ["n" "v"];
              key = "<leader>ca";
              action.__raw = "vim.lsp.buf.code_action";
              options = {
                desc = "LSP: [C]ode [A]ction";
              };
            }
          ];

          lspBuf = {
            "<leader>rn" = {
              action = "rename";
              desc = "LSP: [R]e[n]ame";
            };
            "<F2>" = {
              action = "rename";
              desc = "LSP: [R]e[n]ame";
            };
            "gD" = {
              action = "declaration";
              desc = "LSP: [G]oto [D]eclaration";
            };
          };
        };

        onAttach =
          #lua
          ''
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
            end

            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
              vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
              })
            end

            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
              end, "[T]oggle Inlay [H]ints")
            end
          '';
      };
    };
    autoGroups = {
      "kickstart-lsp-attach" = {
        clear = true;
      };
    };
    extraConfigLua = ''
      local signs = {
        Error = "",
        Warn = "",
        Hint = "",
        Info = "",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    '';
  };
}
