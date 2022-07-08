if exists('g:tomatotimer_loaded')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

command! TomatoStart lua require'tomatotimer'.start()
command! TomatoStatus lua require'tomatotimer'.status()
command! TomatoStop lua require'tomatotimer'.stop()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:tomatotimer_loaded = 1
