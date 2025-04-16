local function set_background(content)
  local cmd = 'osascript -e \'tell application "Finder" to set desktop picture to POSIX file "' .. content .. "\"'"
  vim.fn.system(cmd)
end

local function select_background(prompt_bufnr, map)
  local function set_the_background(close)
    local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
    set_background(content.cwd .. "/" .. content.value)
    if close then
      require("telescope.actions").close(prompt_bufnr)
    end
  end

  map("i", "<C-a>", function()
    set_the_background()
  end)

  map("n", "<C-a>", function()
    set_the_background()
  end)

  map("i", "<CR>", function()
    set_the_background(true)
  end)

  map("n", "<CR>", function()
    set_the_background(true)
  end)
end

local function image_selector(prompt, cwd)
  return function()
    require("telescope.builtin").find_files {
      prompt_title = prompt,
      cwd = cwd,

      attach_mappings = function(prompt_bufnr, map)
        select_background(prompt_bufnr, map)

        -- Please continue mapping (attaching additional key maps):
        -- Ctrl+n/p to move up and down the list.
        return true
      end,
    }
  end
end

local anime_selector = image_selector("< Anime Bobs > ", "~/code/wallpapers/ThePrimeagen")

return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "aaronhallaert/advanced-git-search.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-node-modules.nvim",
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require("telescope").setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "advanced_git_search")
    pcall(require("telescope").load_extension, "octo")
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
