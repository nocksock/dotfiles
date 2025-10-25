-- Helper Methods {{{
---@diagnostic disable: unused-local, unused-function
local ls = require('luasnip')
local s = ls.s
local mate = ls.parser.parse_snipmate
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep ---@diagnostic disable-line: unused-local
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require('luasnip.util.events')
local ai = require('luasnip.nodes.absolute_indexer')
local same = function(index)
	return f(function(arg)
		return arg[1]
	end, { index, index })
end
-- }}}

ls.filetype_extend('zsh', { 'bash', 'sh' })

return {
  mate(
  "#!script",
    [=[
      #!/usr/bin/env zsh
      # function to show help text
      function show_help() {
        cat << eof
      usage: \$(basename \$0) [options] [file or -]
      
      options:
        -f file       read lines from file instead of stdin
        -h, --help    display this help message and exit
      
      description:
        This script does something useful.
      
      examples:
        \$(basename \$0) -f urls.txt
        cat urls.txt | \$(basename \$0)
        \$(basename \$0) < urls.txt
      eof
      }
      
      function main() {
        local input_source="\$1"
      
        if [[ "\$input_source" != "-" ]]; then
          if [[ ! -e "\$input_source" ]]; then
            echo "error: file '\$input_source' does not exist."
            exit 1
          fi
          exec 3< "\$input_source"
        else
          exec 3<&0
        fi
      
        while read -u 3 line; do
          if [[ \$line == \#* ]] || [[ \$line == "" ]]; then
            continue
          fi
      
          echo "Processing \$line..."
        done
      
        exec 3<&-
      }
      
      zparseopts -D -E -F -A opts h -help f:
      
      if [[ -n "\${opts[(i)--help]}" ]] || [[ -n "\${opts[(i)-h]}" ]]; then
        show_help
        exit 0
      fi
      
      echo "\${opts[-f]}"
      
      if [[ -n "\${opts[-f]}" ]]; then
        input_file="\${opts[-f]}"
      elif [ ! -t 0 ]; then
        input_file="-"
      else
        echo "no input file specified and no input from stdin."
        show_help
        exit 1
      fi
      
      main "\$input_file"
    ]=]
  )
}
