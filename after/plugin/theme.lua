local function apply_theme_for_terminal()
	local term_program = vim.env.TERM_PROGRAM or ""
	if term_program == "iTerm.app" then
		vim.cmd.colorscheme("solarized")
		vim.opt.number = false
		vim.opt.relativenumber = false
		vim.opt.signcolumn = "no"
		vim.cmd("hi clear StatusLine")
		vim.cmd("hi clear LineNr")
		vim.cmd("hi clear SignColumn")
		vim.opt.laststatus = 0
	else
		vim.cmd.colorscheme("tokyonight-night")
	end
end

apply_theme_for_terminal()
