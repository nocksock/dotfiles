command! GitRoot execute "cd" system('git rev-parse --show-toplevel')
command! Gr GitRoot
command! TabGitRoot execute "tcd" system('git rev-parse --show-toplevel')
command! Tgr TabGitRoot
command! GCAFP Git commit --amend --no-edit | Git push --force-with-lease
