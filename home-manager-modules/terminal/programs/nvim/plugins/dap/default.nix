{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      dap = {
        enable = true;
        extensions = {
          dap-ui.enable = true;
          dap-virtual-text.enable = true;
        };
        adapters = {
          servers = {
            pwa-node = {
              host = "localhost";
              port = ''''${port}'';
              executable = {
                command = "${pkgs.vscode-js-debug}/bin/js-debug";
                args = [
                  ''''${port}''
                ];
              };
            };
          };
        };
        configurations = {
          typescript = [
            {
              name = "Launch Test Program (pwa-node with vitest)";
              request = "launch";
              type = "pwa-node";
              cwd = ''''${workspaceFolder}'';
              program = ''''${workspaceFolder}/node_modules/vitest/vitest.mjs'';
              args = ["--threads" "false"];
              autoAttachChildProcesses = false;
              trace = true;
              console = "integratedTerminal";
              sourceMaps = true;
              smartStep = true;
            }
          ];
        };
        signs = {
          dapBreakpoint = {
            text = "";
            texthl = "DapBreakpoint";
          };
          dapBreakpointCondition = {
            text = "";
            texthl = "dapBreakpointCondition";
          };
          dapBreakpointRejected = {
            text = "";
            texthl = "DapBreakpointRejected";
          };
          dapLogPoint = {
            text = "";
            texthl = "DapLogPoint";
          };
          dapStopped = {
            text = "";
            texthl = "DapStopped";
          };
        };
      };
    };
    extraConfigLua = ''
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    '';
    keymaps = [
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').continue()
            end
          '';
        key = "<leader>dc";
        options = {
          desc = "Continue";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              local render = require("dapui.config").render
              render.max_type_length = (render.max_type_length == nil) and 0 or nil
              require("dapui").update_render(render)
            end
          '';
        key = "<leader>dut";
        options = {
          desc = " toggle types";
        };
        mode = ["n"];
      }
      {
        action =
          # lua
          ''
            function()
              require('dap').step_over()
            end
          '';
        key = "<leader>dO";
        options = {
          desc = "Step over";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').step_into()
            end
          '';
        key = "<leader>di";
        options = {
          desc = "Step Into";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').step_out()
            end
          '';
        key = "<leader>do";
        options = {
          desc = "Step Out";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').pause()
            end
          '';
        key = "<leader>dp";
        options = {
          desc = "Pause";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').toggle_breakpoint()
            end
          '';
        key = "<leader>db";
        options = {
          desc = "Toggle Breakpoint";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
            	require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end
          '';
        key = "<leader>dB";
        options = {
          desc = "Breakpoint (conditional)";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').repl.toggle()
            end
          '';
        key = "<leader>dR";
        options = {
          desc = "Toggle REPL";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
            	local dap = require('dap')
            	dap.disconnect()
            	dap.close()
            	dap.run_last()
            end
          '';
        key = "<leader>dr";
        options = {
          desc = "Restart Debugger";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').run_last()
            end
          '';
        key = "<leader>dl";
        options = {
          desc = "Run Last";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').session()
            end
          '';
        key = "<leader>ds";
        options = {
          desc = "Session";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').terminate()
            end
          '';
        key = "<leader>dt";
        options = {
          desc = "Terminate";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap.ui.widgets').hover()
            end
          '';
        key = "<leader>dw";
        options = {
          desc = "Hover Widget";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').run_to_cursor()
            end
          '';
        key = "<leader>dC";
        options = {
          desc = "Run all lines up to cursor";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dapui').eval(nil, { enter = true })
            end
          '';
        key = "<leader>?";
        options = {
          desc = "Evaluate value under cursor";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dapui').toggle()
            end
          '';
        key = "<leader>du";
        options = {
          desc = "Toggle UI";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dapui').eval()
            end
          '';
        key = "<leader>de";
        options = {
          desc = "Eval";
        };
        mode = ["n"];
      }
    ];
  };
}
