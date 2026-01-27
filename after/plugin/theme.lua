local function apply_theme_for_terminal()
	local term_program = vim.env.TERM_PROGRAM or ""
	if term_program == "iTerm.app" then
		vim.cmd.colorscheme("deus")
	else
		vim.cmd.colorscheme("deus")
	end
end

apply_theme_for_terminal()
