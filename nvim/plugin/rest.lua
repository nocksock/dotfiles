require 'baggage'.from {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/rest-nvim/rest.nvim"
}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.http" },
  callback = function()
    require("rest-nvim").setup({
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Encode URL before making request
      encode_url = true,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 300,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        -- show the generated curl command in case you want to launch
        -- the same request via the terminal (can be verbose)
        show_curl_command = true,
        show_http_info = true,
        show_headers = true,
        -- executables or functions for formatting response body [optional]
        -- set them to false if you want to disable them
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({ "prettier", "--parser", "html" }, body)
          end
        },
      },
      -- Jump to request line on run
      jump_to_request = true,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    })
    return true
  end
})
