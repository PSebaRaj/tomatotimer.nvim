# tomatotimer.nvim
[![Latest Release](https://img.shields.io/github/release/psebaraj/tomatotimer.nvim.svg?style=for-the-badge)](https://github.com/psebaraj/tomatotimer.nvim/releases)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=for-the-badge)](/LICENSE)
[![Build Status](https://img.shields.io/github/workflow/status/psebaraj/tomatotimer.nvim/CI?style=for-the-badge)](https://github.com/PSebaRaj/tomatotimer.nvim/actions/workflows/CI.yml)

Implement a pomodoro timer and stopwatch into Neovim in Lua.


## To-Do:
- [ ] Implement stopwatch
- [x] Embed within [Lualine](https://github.com/vim-airline/vim-airline)
- [ ] Fix problem --> unable to change pomodoro times

## Dependencies:
- [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) for UI Components

## Installation

### NVIM-Plug:
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
- NEED TO ADD

### Vimscript
```
let g:tomatotimer_time_work = 25
let g:tomatotimer_time_break_short = 5
let g:tomatotimer_time_break_long = 20
let g:tomatotimer_timers_to_long_break = 4`
```
## Usage
| Command		| Description                                           |
|---------------|-------------------------------------------------------|
| :TomatoStart  | Starts the Pomodoro sessio                            |
| :TomatoStop   | Stops the Pomodoro session.                           |
| :TomatoStatus | Displays time remaining of current Pomodoro session   |
