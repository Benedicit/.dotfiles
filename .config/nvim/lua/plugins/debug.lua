--[[
   From LazyVim
   keys = {
      { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
--]]
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    event = "VeryLazy",
    config = function()
      local dap = require("dap")
      local keymap = vim.keymap.set

      require("mason-nvim-dap").setup({
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          "delve",
          "python",
          "javadbg",
          "mock",
          "javatest",
          "js",
        },
      })
      keymap("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
      keymap("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
      keymap("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })
      keymap("n", "<leader>dO", dap.step_over, { desc = "Debug: Step Over" })
      keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      keymap("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Breakpoint" })
      keymap("n", "<leader>dt", dap.terminate, { desc = "terminate" })

      -- Setup for codelldb: The C, C++, Rust debugger in this config, source: https://journals.kaungmyatthu.dev/Vim/Neovim-C++-debugger-setup-using-nvim-dap-and-mason
      -- Added nil checks to remove warnings
      dap.adapters.codelldb = function(on_adapter)
        -- This asks the system for a free port
        local tcp = vim.loop.new_tcp()
        tcp:bind("127.0.0.1", 0)
        local port = tcp:getsockname().port
        tcp:shutdown()
        tcp:close()

        -- Start codelldb with the port
        local stdout = vim.loop.new_pipe(false)
        local stderr = vim.loop.new_pipe(false)
        local opts = {
          stdio = { nil, stdout, stderr },
          args = { "--port", tostring(port) },
        }
        local handle
        local pid_or_err
        local path = require("mason-registry").get_package("codelldb"):get_install_path()
        handle, pid_or_err = vim.loop.spawn(path, opts, function(code)
          stdout:close()
          stderr:close()
          if handle then handle:close() end
          if code ~= 0 then print("codelldb exited with code", code) end
        end)
        if not handle then
          vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
          stdout:close()
          stderr:close()
          return
        end
        vim.notify("codelldb started. pid=" .. pid_or_err)
        stderr:read_start(function(err, chunk)
          assert(not err, err)
          if chunk then vim.schedule(function()
            require("dap.repl").append(chunk)
          end) end
        end)
        local adapter = {
          type = "server",
          host = "127.0.0.1",
          port = port,
        }
        -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
        -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
        vim.defer_fn(function()
          on_adapter(adapter)
        end, 1000)
      end

      -- don't forget to compile/build with debug symbols, otherwise it won't work.
      dap.configurations.cpp = {
        {
          name = "runit",
          type = "codelldb",
          request = "launch",

          program = function()
            return vim.fn.input("", vim.fn.getcwd(), "file")
          end,

          args = { "--log_level=all" },
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          terminal = "integrated",

          pid = function()
            local handle = io.popen("pgrep hw$")
            local result
            if handle then
              result = handle:read()
              handle:close()
            end
            return result
          end,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.h = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
  {
    -- Give the debugger a nice ui
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    event = "VeryLazy",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      dapui.setup({ ---@diagnostic disable-line: missing-fields
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          element = "repl",
          enabled = true,
          icons = {
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set("n", "<du>", dapui.toggle, { desc = "Debug: See last session result." })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  --[[
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      -- uses the debugypy installation by mason
      -- "~/. local/share/nvim/mason/packages/debugpy/venv/bin/python"
      local debugpyPythonPath = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python3"
      require("dap-python").setup(debugpyPythonPath)
    end,
  },
  --]]
}
