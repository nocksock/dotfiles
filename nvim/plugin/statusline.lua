-- statusline
-- a super simple, custom status bar written in lua*
local function root_name()
   return string.match(vim.fn.getcwd(), "/([%w-_ ]+)$") or ""
end

local stl = function(color)
	return table.concat({
    color('StatusLine'),
		color('stlModeMsg'),
		vim.api.nvim_get_mode().mode:upper(),
		color('stlLeft'),
    root_name(),
		'%(%m%r%h %)%-10.30f%q',
		color('stlMid'),
		"%-5.20{get(b:,'gitsigns_head','')}",
		"%{get(b:,'gitsigns_status','')}",
		'%=',
		"/%{@/}",
		color('stlRight'),
		vim.lsp.buf.server_ready() and "+lsp" or "",
		'%y',
	}, " ")
end

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

function StatusLine(type)
	-- TODO add state groups for insert, select, etcpp
	if type == 'active' then
		return stl(color_state(''))
	end
	if type == 'inactive' then
		return stl(color_state('NC'))
	end
end

-- TODO convert to proper lua
vim.api.nvim_exec([[
  highlight def link stlModeMsg ModeMsg
  highlight def link stlLeftNC StatusLineNC
  highlight def link stlMidNC StatusLineNC
  highlight def link stlRightNC StatusLineNC
  highlight def link stlLeft StatusLine
  highlight def link stlMid StatusLine
  highlight def link stlRight StatusLine

	augroup statusline
		au!
		autocmd WinEnter,BufEnter * setlocal statusline=%!v:lua.StatusLine('active')
		autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.StatusLine('inactive')
	augroup END
]], false)
