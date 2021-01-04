let g:nvim_config_root = stdpath('config')
" add the base.vim config
execute 'source ' . g:nvim_config_root . '/' . "base.vim"
" add home.vim config
execute 'source ' . g:nvim_config_root . '/' . "home.vim"
