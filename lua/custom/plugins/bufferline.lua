return {
  "akinsho/bufferline.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  --[[ tag = "v3.*", ]]
  config = function()
    local status_ok, bufferline = pcall(require, "bufferline")
    if not status_ok then
      return
    end
    vim.opt.termguicolors = true

    bufferline.setup {
      options = {
        mode = "buffers", -- or "tabs"
        -- 🗙 When closing buffer: switch to previous, split, next, and then delete
        close_command = "bp|sp|bn|bd! %d",
        right_mouse_command = "bp|sp|bn|bd! %d",

        -- 👈 Clicking switches buffer
        left_mouse_command = "buffer %d",

        -- 🎨 Icons
        modified_icon = "",
        show_close_icon = false, -- disables the far-right X
        show_buffer_close_icons = true, -- enables per-buffer X icon     }

        -- 🧭 Truncation symbols when tabs overflow
        left_trunc_marker = "",
        right_trunc_marker = "",

        -- 🔤 Tab display constraints
        max_name_length = 18, -- name of each buffer
        max_prefix_length = 15, -- e.g., "init.lua" => "ini..." if long
        tab_size = 18, -- minimum size for each tab
        enforce_regular_tabs = false, -- if true, makes all tabs equal size

        -- 🔍 Better buffer visibility
        view = "multiwindow", -- buffers grouped per window
        show_tab_indicators = true, -- shows modified/active icons
        indicator = {
          style = "underline", -- underline current buffer
        },

        diagnostics = "nvim_lsp", -- enable if you want LSP signs

        themable = true,

        -- 🪟 Display even when only one buffer
        always_show_bufferline = true,

        -- ─ Visual separator between tabs
        separator_style = "thin", -- "slant", "thick", "thin", or custom pair
      },
    }

    -- 🔑 Keymaps for buffer navigation
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<leader>bn", "<cmd>enew<CR>", { noremap = true, silent = true })

    -- Switch to next buffer
    vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })

    -- Switch to previous buffer
    vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })

    -- Move current buffer position left in bufferline
    vim.keymap.set("n", "<leader><", "<cmd>BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })

    -- Move current buffer position right in bufferline
    vim.keymap.set("n", "<leader>>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })

    -- Close the current buffer
    vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close Buffer" })

    -- Pick a buffer to jump to (shows letters for selection)
    vim.keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<CR>", { desc = "Pick Buffer (Jump To)" })

    -- Pick a buffer to close (shows letters for selection)
    vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Pick Buffer (Close)" })

    -- Close all buffers except the current one
    vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close Other Buffers" })

    -- Sort buffers by their directory path
    vim.keymap.set("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Sort Buffers by Directory" })
    -- Sort buffers by their file extension
    vim.keymap.set("n", "<leader>bsd", "<cmd>BufferLineSortByExtension<CR>", { desc = "Sort Buffers by Extension" }) -- 📦 Internal tab-aware buffer state tracking

    local cache = {}
    local utils = {}

    -- ✅ Checks if a buffer is valid and listed
    utils.is_valid = function(buf_num)
      if not buf_num or buf_num < 1 then
        return false
      end
      local exists = vim.api.nvim_buf_is_valid(buf_num)
      return vim.bo[buf_num].buflisted and exists
    end

    -- 🧼 Returns list of valid, listed buffers
    utils.get_valid_buffers = function()
      local buf_nums = vim.api.nvim_list_bufs()
      local ids = {}
      for _, buf in ipairs(buf_nums) do
        if utils.is_valid(buf) then
          ids[#ids + 1] = buf
        end
      end
      return ids
    end

    -- 🧠 Restores tab's buffer list when re-entering a tab
    vim.api.nvim_create_autocmd("TabEnter", {
      callback = function()
        local tab = vim.api.nvim_get_current_tabpage()
        local buf_nums = cache[tab]
        if buf_nums then
          for _, k in pairs(buf_nums) do
            vim.api.nvim_buf_set_option(k, "buflisted", true)
          end
        end
      end,
    })

    vim.api.nvim_create_autocmd("TabLeave", {
      callback = function()
        local tab = vim.api.nvim_get_current_tabpage()
        local buf_nums = utils.get_valid_buffers()
        cache[tab] = buf_nums
        for _, k in pairs(buf_nums) do
          vim.api.nvim_buf_set_option(k, "buflisted", false)
        end
        last_tab = tab
      end,
    })
    vim.api.nvim_create_autocmd("TabClosed", {
      callback = function()
        cache[last_tab] = nil
      end,
    })
    vim.api.nvim_create_autocmd("TabNewEntered", {
      callback = function()
        vim.api.nvim_buf_set_option(0, "buflisted", true)
      end,
    })
  end,
}
