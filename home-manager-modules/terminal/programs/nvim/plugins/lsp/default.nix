{
    programs.nixvim = {
        plugins = {
            cmp-nvim-lsp.enable = true;
            fidget.enable = true;
            lsp = {
                enable = true;
                servers = {
                    tsserver.enable = true;
                    nil-ls.enable = true;
                    lua-ls = {
                        enable = true;
                        settings.telemetry.enable = false;
                    };
                    rust-analyzer = {
                        enable = true;
                        installCargo = true;
                    };
                    cssls.enable = true;
                    bashls.enable = true;
                    eslint.enable = true;
                    omnisharp.enable = true;
                    astro.enable = true;
                };

                keymaps = {
                    diagnostic = {
                        "<leader>q" = {
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
                            desc = "LSP: [G]oto [D]efinition";
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
                            desc = "LSP: [G]oto [R]eferences";
                        };
                    }
                    {
                        mode = "n";
                        key = "gI";
                        action.__raw = "require('telescope.builtin').lsp_implementations";
                        options = {
                            desc = "LSP: [G]oto [I]mplementation";
                        };
                    }
                    {
                        mode = "n";
                        key = "<leader>D";
                        action.__raw = "require('telescope.builtin').lsp_type_definitions";
                        options = {
                            desc = "LSP: Type [D]efinition";
                        };
                    }
                    {
                        mode = "n";
                        key = "<leader>ds";
                        action.__raw = "require('telescope.builtin').lsp_document_symbols";
                        options = {
                            desc = "LSP: [D]ocument [S]ymbols";
                        };
                    }
                    {
                        mode = "n";
                        key = "<leader>ws";
                        action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
                        options = {
                            desc = "LSP: [W]orkspace [S]ymbols";
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

                onAttach = ''
                    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                    -- to define small helper and utility functions so you don't have to repeat yourself.
                    --
                    -- In this case, we create a function that lets us more easily define mappings specific
                    -- for LSP related items. It sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
                    end

                    -- The following two autocommands are used to highlight references of the
                    -- word under the cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                                    buffer = bufnr,
                                    group = highlight_augroup,
                                    callback = vim.lsp.buf.document_highlight,
                                    })

                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = bufnr,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                        })

                vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                        })
                end

                    -- The following autocommand is used to enable inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        map('<leader>th', function()
                                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                                end, '[T]oggle Inlay [H]ints')
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
                    local status_ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
                    if not status_ok_cmp_nvim_lsp then
                        return
                    end
                    local status_ok_lspConfig, lspConfig = pcall(require, "lspconfig")
                    if not status_ok_lspConfig then
                        return
                    end
                    local status_ok_typescript, typescript = pcall(require, "typescript")
                    if not status_ok_typescript then
                        return
                    end

                    local capabilities = cmp_nvim_lsp.default_capabilities()
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

                    function PopulateQuickfixWithDotNetErrors()
                        local command_output = vim.fn.systemlist("dotnet build || dotnet build server")

                        vim.fn.setqflist({}, "r")

                        local quickfix_list = {}
                        local seen_errors = {}

                        for _, line in ipairs(command_output) do
                            local filename, lnum, col, text = string.match(line, "([^:]+)%((%d+),(%d+)%)%s*:%s*error%s*%w+%s*:%s*(.+)")
                            if filename and lnum and col and text then
                                local error_key = filename .. ":" .. lnum .. ":" .. col .. ":" .. text
                                if not seen_errors[error_key] then
                                    seen_errors[error_key] = true
                                    table.insert(quickfix_list, {
                                        filename = filename,
                                        lnum = tonumber(lnum),
                                        col = tonumber(col),
                                        text = text
                                    })
                                end
                            end
                        end

                        -- Set the quickfix list
                        vim.fn.setqflist(quickfix_list, "r")

                        -- Open the quickfix window
                        vim.cmd("copen")
                    end


                    lspConfig.omnisharp.setup({
                        on_attach = function(client, bufnr)
                            on_attach_global(client, bufnr)
                            vim.keymap.set(
                                "n",
                                "<Leader>l1",
                                ":lua PopulateQuickfixWithDotNetErrors()<CR>",
                                { noremap = true, silent = true, desc = "Populate quickfix list with dotnet errors" }
                            )
                        end,
                        handlers = {
                            ["textDocument/definition"] = require("omnisharp_extended").handler,
                        },
                        cmd = { "/etc/profiles/per-user/kyle/bin/OmniSharp" },
                        settings = {
                            FormattingOptions = {
                                EnableEditorConfigSupport = true,
                                OrganizeImports = nil,
                            },
                            MsBuild = {
                                LoadProjectsOnDemand = nil,
                            },
                            RoslynExtensionsOptions = {
                                EnableAnalyzersSupport = nil,
                                EnableImportCompletion = nil,
                                AnalyzeOpenDocumentsOnly = nil,
                            },
                            Sdk = {
                                IncludePrereleases = true,
                            },
                        },
                    })

                    function PopulateQuickfixWithTypescriptErrors()
                        local command_output = vim.fn.systemlist("tsc --noEmit --pretty false 2>&1 | grep '([^,]*,[^)]*)'")

                        vim.fn.setqflist({}, "r")

                        for _, line in ipairs(command_output) do
                            local filename, lnum, col, text = line:match("(%S+)%((%d+),(%d+)%): error%s(.+)")
                            if filename and lnum and col and text then
                                local entry = {
                                    filename = filename,
                                    lnum = tonumber(lnum),
                                    col = tonumber(col),
                                    text = text,
                                }
                                vim.fn.setqflist({ entry }, "a")
                            end
                        end
                        vim.cmd("copen")
                    end

                    function PopulateQuickfixWithEslintErrors()
                        -- Run ESLint and get the output
                        local command_output = vim.fn.systemlist("eslint --ext .js,.jsx,.json,.html,.ts,.tsx,.mjs --report-unused-disable-directives --max-warnings 0 .")

                        -- Clear the quickfix list
                        vim.fn.setqflist({}, "r")

                        -- Variables to hold the current file and its errors
                        local current_file = nil
                        local quickfix_list = {}

                        for _, line in ipairs(command_output) do
                            -- Check if the line is a file path
                            if string.match(line, "^/[^ ]+") then
                                current_file = line
                            else
                                -- Ensure we have a current file and the line matches the error format
                                if current_file and string.match(line, "^%s*%d+:%d+") then
                                    -- Parse the line number, column, and error message
                                    local lnum, col, _, text = string.match(line, "^%s*(%d+):(%d+)%s+(%w+)%s+(.+)$")
                                    if lnum and col and text then
                                        table.insert(quickfix_list, {
                                            filename = current_file,
                                            lnum = tonumber(lnum),
                                            col = tonumber(col),
                                            text = text
                                        })
                                    end
                                end
                            end
                        end

                        -- Set the quickfix list
                        vim.fn.setqflist(quickfix_list, "r")

                        -- Open the quickfix window
                        vim.cmd("copen")
                    end

                    lspConfig.tsserver.setup({
                        on_attach = function(client, bufnr)
                            vim.keymap.set(
                                "n",
                                "<leader>l1",
                                typescript.actions.addMissingImports,
                                { buffer = bufnr, remap = false, silent = true, desc = "Add missing imports" }
                            )
                            vim.keymap.set(
                                "n",
                                "<leader>l2",
                                typescript.actions.removeUnused,
                                { buffer = bufnr, remap = false, silent = true, desc = "Remove unused imports" }
                            )
                            vim.keymap.set(
                                "n",
                                "<leader>l3",
                            function()
                                    local source = vim.api.nvim_buf_get_name(bufnr)
                                    vim.ui.input(
                                        {prompt = "New path: ", default = source},
                                        function(input)
                                            if input == "" or input == source or input == nil then
                                                return
                                            end
                                            typescript.renameFile(source, input)
                                        end
                                    )
                                end,
                                { buffer = bufnr, remap = false, silent = true, desc = "File rename" }
                            )
                            vim.keymap.set(
                                "n",
                                "<Leader>l4",
                                ":lua PopulateQuickfixWithTypescriptErrors()<CR>",
                                { noremap = true, silent = true, desc = "Populate quickfix list with typescript errors" }
                            )
                            vim.keymap.set(
                                "n",
                                "<Leader>l5",
                                ":lua PopulateQuickfixWithEslintErrors()<CR>",
                                { noremap = true, silent = true, desc = "Populate quickfix list with eslint errors" }
                            )
                            on_attach_global(client, bufnr)
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
