{pkgs, ...}: {
  programs.nixvim.plugins.lsp.servers.ts_ls = {
    enable = true;
    settings = {
      jsx_close_tag = {
        enable = true;
        filetypes = ["javascriptreact" "typescriptreact"];
      };
    };
    onAttach.function =
      #lua
      ''
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

          vim.ui.input({
            prompt = "Target: ",
            completion = "file",
            default = source_file,
          }, function(input)
            if not input or input == "" then
              vim.notify("Rename canceled!", vim.log.levels.WARN)
              return
            end

            local target_file = input
            local dir = target_file:match(".*/")

            if dir and vim.fn.isdirectory(dir) == 0 then
              vim.fn.mkdir(dir, "p")
            end

            -- First move the file
            local ok = pcall(vim.lsp.util.rename, source_file, target_file)
            if not ok then
              vim.notify("Failed to move file!", vim.log.levels.ERROR)
              return
            end

            -- Then update references
            vim.lsp.buf.execute_command({
              command = "_typescript.applyRenameFile",
              arguments = {
                {
                  sourceUri = "file://" .. source_file,
                  targetUri = "file://" .. target_file,
                },
              },
              title = "Rename TypeScript file",
            })
          end)
        end, { desc = "Rename file with TypeScript LSP" })

        vim.api.nvim_create_user_command("PopulateQuickfixTS", function()
          local command_output =
            vim.fn.systemlist("${pkgs.nodejs_22}/bin/npx tsc -b --pretty false || ${pkgs.typescript}/bin/tsc")
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
          local command_output =
            vim.fn.systemlist("${pkgs.nodejs_22}/bin/npx eslint --report-unused-disable-directives --max-warnings 0 .")
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

        vim.api.nvim_create_user_command("PopulateQuickfixVitest", function()
          local command_output = vim.fn.systemlist("${pkgs.nodejs_22}/bin/npx vitest run --silent --reporter json")
          vim.fn.setqflist({}, "r")

          local quickfix_list = {}

          local testResults = vim.fn.json_decode(command_output) -- Decode JSON output

          for _, suite in ipairs(testResults.testResults) do
            for _, assertion in ipairs(suite.assertionResults) do
              if assertion.status == "failed" then
                local full_name = assertion.fullName
                local failure_messages = assertion.failureMessages
                local test_file = suite.name
                local failure_message = table.concat(failure_messages, "\n")

                local line_number = nil
                for _, message in ipairs(failure_messages) do
                  local _, _, file_path, line = string.find(message, "at (.+):(%d+):")
                  if file_path and line then
                    line_number = tonumber(line)
                    break
                  end
                end

                if test_file and line_number and failure_message then
                  local entry = {
                    filename = test_file,
                    lnum = line_number,
                    col = 1,
                    text = failure_message,
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
            vim.notify("No Vitest errors found", vim.log.levels.INFO)
            vim.cmd("cclose")
          end
        end, { desc = "Populate quickfix list with Vitest errors" })

        vim.keymap.set(
          "n",
          "<leader>l1",
          ":LspAddMissingImports<CR>",
          { buffer = bufnr, remap = false, silent = true, desc = "Add missing imports" }
        )
        vim.keymap.set(
          "n",
          "<leader>l2",
          ":LspRemoveUnusedImports<CR>",
          { buffer = bufnr, remap = false, silent = true, desc = "Remove unused imports" }
        )
        vim.keymap.set(
          "n",
          "<leader>l3",
          ":LspRenameFile<CR>",
          { buffer = bufnr, remap = false, silent = true, desc = "Rename file" }
        )
        vim.keymap.set(
          "n",
          "<Leader>l4",
          ":PopulateQuickfixTS<CR>",
          { noremap = true, silent = true, desc = "Populate quickfix list with TypeScript errors" }
        )
        vim.keymap.set(
          "n",
          "<Leader>l5",
          ":PopulateQuickfixESLint<CR>",
          { noremap = true, silent = true, desc = "Populate quickfix list with ESLint errors" }
        )
        vim.keymap.set(
          "n",
          "<Leader>l6",
          ":PopulateQuickfixVitest<CR>",
          { noremap = true, silent = true, desc = "Populate quickfix list with Vitest errors" }
        )
      '';
  };
}
