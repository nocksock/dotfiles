-- statusline
-- a super simple, custom status bar written in lua*

local function color_state(state, wrap)
	local function cg(name)
		return '%#' .. name .. '#'
	end

	return function(name)
		if wrap == nil or wrap == true then
			return cg(name .. state)
		end

		return name .. state
	end
end

local lsp_status = function()
	return vim.lsp.buf.server_ready() and "+lsp" or ""
end

local mode = function()
	return vim.api.nvim_get_mode().mode:upper()
end

local stl = function(color)
	return table.concat({
		color('stlModeMsg'),
		mode(),
		color('stlLeft'),
		'%(%m%r%h %)%f',
		color('stlMid'),
		"%{get(b:,'gitsigns_head','')}",
		"%{get(b:,'gitsigns_status','')}",
		'%=',
		"/%{@/}",
		color('stlRight'),
		lsp_status(),
		'%y',
	}, " ")
end

function StatusLine(type)
	if type == 'active' then
		return stl(color_state(''))
	end
	if type == 'inactive' then
		return stl(color_state('NC'))
	end
end

vim.api.nvim_exec([[
  augroup statusline
    au!
    autocmd WinEnter,BufEnter * setlocal statusline=%!v:lua.StatusLine('active')
    autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.StatusLine('inactive')
  augroup END
]], false)
