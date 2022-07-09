# tomatotimer.nvim
[![Latest Release](https://img.shields.io/github/release/psebaraj/tomatotimer.nvim.svg?style=for-the-badge)](https://github.com/psebaraj/tomatotimer.nvim/releases)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=for-the-badge)](/LICENSE)
[![Build Status](https://img.shields.io/github/workflow/status/psebaraj/tomatotimer.nvim/CI?style=for-the-badge)](https://github.com/PSebaRaj/tomatotimer.nvim/actions/workflows/CI.yml)

Implement a pomodoro timer and stopwatch into Neovim in Lua. WIP.


## To-Do:
- [ ] Implement stopwatch
- [x] Embed within [Lualine](https://github.com/vim-airline/vim-airline)
- Document:
	- [x] Changing times in Lua
	- [x] Lualine integration
- Fix:
	- [ ] Unable to change pomodoro times from default

## Dependencies:
- [Neovim](https://github.com/neovim/neovim/releases/tag/nightly) nightly
- [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) for UI Components

## Installation

### VIM-Plug:
```
Plug "MunifTanjim/nui.nvim"
Plug "psebaraj/tomatotimer.nvim"
```

### Packer:
```
use {
   'psebaraj/tomatotimer.nvim',
   requires = 'MunifTanjim/nui.nvim'
}
```

## Configuration

### Lua
```
use {
    'psebaraj/tomatotimer.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = function()
        require('tomatotimer').setup({
            time_work = 20,
            time_break_short = 5,
            time_break_long = 20,
            timers_to_long_break = 4
        })
    end
}
```

### Vimscript
```
let g:tomatotimer_time_work = 20
let g:tomatotimer_time_break_short = 5
let g:tomatotimer_time_break_long = 20
let g:tomatotimer_timers_to_long_break = 4
```

## Usage

### Commands
| Command		| Description                                           |
|---------------|-------------------------------------------------------|
| :TomatoStart  | Starts the Pomodoro session                           |
| :TomatoStop   | Stops the Pomodoro session                            |
| :TomatoStatus | Displays time remaining of current Pomodoro session   |

### Lualine
```
require('lualine').setup({
    sections = {
        lualine_c = { 'filename', require('tomatotimer').statusline }
    }
})
```
