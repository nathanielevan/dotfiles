-- Unset relativenumber in insert mode
vim.cmd("au InsertEnter * set norelativenumber")
vim.cmd("au InsertLeave * set relativenumber")

-- Unset paste mode when leaving insert mode
vim.cmd("au InsertLeave * set nopaste")

-- Remove line number and start in insert mode when entering the terminal
vim.cmd("au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal | startinsert")
