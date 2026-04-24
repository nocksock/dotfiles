local function apply(mode) 
    vim.schedule(function() 
        vim.o.background = mode 
    end)
end

local function watch_color_scheme()
  local job_id = vim.fn.jobstart(
    {'darkman', 'watch'},
    {
      on_stdout = function(_, data, _)
        mode = string.gsub(data[1], "\n", "")
        apply(mode)
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
