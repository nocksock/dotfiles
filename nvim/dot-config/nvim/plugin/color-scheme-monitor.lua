local initial = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")

if initial:match("'prefer%-dark'") then
  vim.o.background = "dark"
else
  vim.o.background = "light"
end

local function watch_color_scheme()
  local job_id = vim.fn.jobstart(
    {'gsettings', 'monitor', 'org.gnome.desktop.interface'},
    {
      on_stdout = function(_, data, _)
        for _, line in ipairs(data) do
          if line:match("color%-scheme:") then
            local scheme = line:match("'prefer%-([^']+)'")
            vim.schedule(function() vim.o.background = scheme end)
          end
        end
      end,
      stdout_buffered = false,
    }
  )
  
  return job_id
end

if _G.color_scheme_job_id then
    vim.fn.jobstop(_G.color_scheme_job_id)
end

_G.color_scheme_job_id = watch_color_scheme()
