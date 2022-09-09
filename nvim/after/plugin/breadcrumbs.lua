local treesitter = require('nvim-treesitter.statusline')

local M = {
  enabled = false,
  status = "",
  statusline_str = "%!v:lua.Breadcrumbs.update()"
}

-- todo: convert to lua
vim.cmd([[
" taken from: https://stackoverflow.com/a/64933820/223852
function! GutterWidth()
    let numberwidth = max([&numberwidth, strlen(line('$')) + 1])
    let numwidth = (&number || &relativenumber) ? numberwidth : 0
    let foldwidth = &foldcolumn

    if &signcolumn == 'yes'
        let signwidth = 2
    elseif &signcolumn =~ 'yes'
        let signwidth = &signcolumn
        let signwidth = split(signwidth, ':')[1]
        let signwidth *= 2  " each signcolumn is 2-char wide
    elseif &signcolumn == 'auto'
        let supports_sign_groups = has('nvim-0.4.2') || has('patch-8.1.614')
        let signlist = execute(printf('sign place ' . (supports_sign_groups ? 'group=* ' : '') . 'buffer=%d', bufnr('')))
        let signlist = split(signlist, "\n")
        let signwidth = len(signlist) > 2 ? 2 : 0
    elseif &signcolumn =~ 'auto'
        let signwidth = 0
        if len(sign_getplaced(bufnr(),{'group':'*'})[0].signs)
            let signwidth = 0
            for l:sign in sign_getplaced(bufnr(),{'group':'*'})[0].signs
                let lnum = l:sign.lnum
                let signs = len(sign_getplaced(bufnr(),{'group':'*', 'lnum':lnum})[0].signs)
                let signwidth = (signs > signwidth ? signs : signwidth)
            endfor
        endif
        let signwidth *= 2   " each signcolumn is 2-char wide
    else
        let signwidth = 0
    endif

    return numwidth + foldwidth + signwidth
endfunction
]])

-- trying out procedural

function M.update()
  local show, statusline = pcall(function()
    return treesitter.statusline({})
  end)

  if show then
    local gutter = vim.fn.GutterWidth()
    M.status = "%#NonText#" .. string.rep(" ", gutter - 1).. "%#LineNr# " .. ( statusline or "" )
  end

  return M.status
end

function M.enable()
  M.enabled = true
  vim.go.winbar = M.statusline_str
end

function M.disable()
  M.enabled = false
  vim.go.winbar = nil
end

function M.toggle()
  if M.enabled then
    M.disable()
  else
    M.enable()
  end
end

_G.Breadcrumbs = {
  update = M.update,
  toggle = M.toggle,
  enable = M.enable,
  disable = M.disable
};

vim.api.nvim_create_user_command("BreadcrumbsToggle", M.toggle, {})
