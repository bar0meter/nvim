return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "aaronhallaert/advanced-git-search.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-node-modules.nvim",
  },
  config = function()
    require("telescope").setup {
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "advanced_git_search")
    pcall(require("telescope").load_extension, "file_browser")
    pcall(require("telescope").load_extension, "node_modules")

    -- See `:help telescope.builtin`
    local builtin = require "telescope.builtin"
    local themes = require "telescope.themes"
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })

    vim.keymap.set("n", "<leader>l", function()
      builtin.find_files {
        file_ignore_patterns = { "^./.git/", "^node_modules/" },
        prompt_title = "[S]earch [F]iles",
        find_command = { "rg", "--files", "--hidden", "-g", "!.git", "--sort", "accessed" },
      }
    end, { desc = "[S]earch [F]iles" })

    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })

    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

    vim.keymap.set("n", "<leader>ff", function()
      builtin.live_grep {
        prompt_title = "[S]earch by [G]rep",
      }
    end, { desc = "[S]earch by [G]rep" })

    vim.keymap.set("n", "<leader>dd", function()
      builtin.diagnostics {
        prompt_title = "[S]earch [D]iagnostics",
      }
    end, { desc = "[S]earch [D]iagnostics" })

    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

    vim.keymap.set("n", "<leader>b", function()
      builtin.buffers {
        prompt_title = "[ ] Find existing buffers",
      }
    end, { desc = "[ ] Find existing buffers" })

    vim.keymap.set("n", "<leader>aa", function()
      anime_selector()
    end, { desc = "[A]nime [A]rt" })

    vim.keymap.set("n", "<leader>gt", function()
      builtin.git_files {
        prompt_title = "Ignore tests folder",
        file_ignore_patterns = { "tests", "functional_tests", "snapshots", ".github", "codegen", "node_modules" },
      }
    end, { desc = "[Ignore tests]" })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set("n", "<leader>ss", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find {}
    end, { desc = "[/] Fuzzily search in current buffer" })
    vim.keymap.set("n", "<leader>ps", function()
      builtin.grep_string { search = vim.fn.input "Grep > " }
    end)

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>sf", function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      }
    end, { desc = "[S]earch [/] in Open Files" })
    vim.keymap.set("n", "<leader>pws", function()
      local word = vim.fn.expand "<cword>"
      builtin.grep_string { search = word }
    end)
    vim.keymap.set("n", "<leader>pWs", function()
      local word = vim.fn.expand "<cWORD>"
      builtin.grep_string { search = word }
    end)

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end, { desc = "[S]earch [N]eovim files" })
  end,
}
