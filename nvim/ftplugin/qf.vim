" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  copen
endfunction

command! RemoveQFItem :call RemoveQFItem()

nmap <buffer> dd :RemoveQFItem<cr>
nmap <buffer> q :close<cr>
nmap <buffer> <esc> :close<cr>
