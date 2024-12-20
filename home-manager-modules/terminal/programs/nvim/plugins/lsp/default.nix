{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      cmp-nvim-lsp.enable = true;
      fidget.enable = true;
      lsp = {
        enable = true;
        servers = {
          ts_ls.enable = true;
          nil_ls.enable = true;
          lua_ls = {
            enable = true;
            settings = {
              telemetry.enable = false;
              diagnostics.globals = ["vim" "require" "client" "bufnr" "event"];
            };
          };
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
              key = "gI";
              action.__raw = "require('telescope.builtin').lsp_implementations";
              options = {
                desc = "LSP: [G]o to [I]mplementation";
              };
            }
            {
              mode = "n";
              key = "<leader>lD";
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
          /*
          lua
          */
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
    extraConfigLua =
      /*
      lua
      */
      ''
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

        require("lspconfig").ts_ls.setup({
          on_attach = function(_, bufnr)
            vim.api.nvim_create_user_command("LspAddMissingImports", function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.addMissingImports" },
                  diagnostics = {},
                },
              })
            end, { desc = "Add missing imports" })

            vim.api.nvim_create_user_command("LspRemoveUnusedImports", function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.removeUnused.ts" },
                  diagnostics = {},
                },
              })
            end, { desc = "Remove unused imports" })

            vim.api.nvim_create_user_command("LspRenameFile", function()
              local source_file = vim.api.nvim_buf_get_name(0)
              local target_file

              vim.ui.input({
                prompt = "Target: ",
                completion = "file",
                default = source_file,
              }, function(input)
                target_file = input
              end)

              if not target_file or target_file == "" then
                vim.print("Rename canceled!")
                return
              end

              local dir = target_file:match(".*/")
              if vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, "p")
              end

              vim.lsp.util.rename(source_file, target_file)

              vim.lsp.buf.execute_command({
                command = "_typescript.applyRenameFile",
                arguments = {
                  {
                    sourceUri = source_file,
                    targetUri = target_file,
                  },
                },
                title = "",
              })
            end, { desc = "Rename file with TypeScript LSP" })

            vim.api.nvim_create_user_command("PopulateQuickfixTS", function()
              local command_output = vim.fn.systemlist("${pkgs.nodejs_22}/bin/npx tsc -b --pretty false || ${pkgs.typescript}/bin/tsc")
              vim.fn.setqflist({}, "r")
              local quickfix_list = {}

              for _, line in ipairs(command_output) do
                local filename, lnum, col, text = line:match("^([^%(]+)%((%d+),(%d+)%)%: error (TS%d+%: (.+))$")
                if filename and lnum and col and text then
                  local entry = {
                    filename = filename,
                    lnum = tonumber(lnum),
                    col = tonumber(col),
                    text = text,
                  }
                  table.insert(quickfix_list, entry)
                end
              end

              if #quickfix_list > 0 then
                vim.fn.setqflist(quickfix_list, "r")
                vim.cmd("copen")
              else
                vim.notify("No typescript issues found", vim.log.levels.INFO)
                vim.cmd("cclose")
              end
            end, { desc = "Populate quickfix list with TypeScript errors" })

            -- Populate quickfix with ESLint errors
            vim.api.nvim_create_user_command("PopulateQuickfixESLint", function()
              local command_output = vim.fn.systemlist("${pkgs.nodejs_22}/bin/npx eslint --report-unused-disable-directives --max-warnings 0 .")
              vim.fn.setqflist({}, "r")

              local current_file = nil
              local quickfix_list = {}

              for _, line in ipairs(command_output) do
                if string.match(line, "^/[^ ]+") then
                  current_file = line
                else
                  if current_file and string.match(line, "^%s*%d+:%d+") then
                    local lnum, col, _, text = string.match(line, "^%s*(%d+):(%d+)%s+(%w+)%s+(.+)$")
                    if lnum and col and text then
                      local entry = {
                        filename = current_file,
                        lnum = tonumber(lnum),
                        col = tonumber(col),
                        text = text,
                      }
                      table.insert(quickfix_list, entry)
                    end
                  end
                end
              end

              if #quickfix_list > 0 then
                vim.fn.setqflist(quickfix_list, "r")
                vim.cmd("copen")
              else
                vim.notify("No eslint issues found", vim.log.levels.INFO)
                vim.cmd("cclose")
              end
            end, { desc = "Populate quickfix list with ESLint errors" })

            -- Keymaps
            vim.keymap.set("n", "<leader>l1", ":LspAddMissingImports<CR>", { buffer = bufnr, remap = false, silent = true, desc = "Add missing imports" })
            vim.keymap.set("n", "<leader>l2", ":LspRemoveUnusedImports<CR>", { buffer = bufnr, remap = false, silent = true, desc = "Remove unused imports" })
            vim.keymap.set("n", "<leader>l3", ":LspRenameFile<CR>", { buffer = bufnr, remap = false, silent = true, desc = "Rename file" })
            vim.keymap.set("n", "<Leader>l4", ":PopulateQuickfixTS<CR>", { noremap = true, silent = true, desc = "Populate quickfix list with TypeScript errors" })
            vim.keymap.set("n", "<Leader>l5", ":PopulateQuickfixESLint<CR>", { noremap = true, silent = true, desc = "Populate quickfix list with ESLint errors" })
          end,
          capabilities = capabilities,
          settings = {
            jsx_close_tag = {
              enable = true,
              filetypes = { "javascriptreact", "typescriptreact" },
            },
          },
        })
      '';
  };
}
