P = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, 'plenary') then
	RELOAD = require('plenary.reload').reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end

-- TODO: convert to lua
vim.cmd([[
  " :E to edit/create file relative to the current buffer
  command! -nargs=1 -complete=customlist,EditRelativeComplete E edit %:h/<args>
  fun! EditRelativeComplete(A,L,P)
        return split(substitute(glob(expand('%:h') .. '/*'), expand('%:h') .. '/', '', 'g'), "\n")
  endfun
]])

vim.api.nvim_create_user_command("EditSnippet", require('luasnip.loaders.from_lua').edit_snippet_files, {})
