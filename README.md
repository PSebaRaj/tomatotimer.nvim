# tomatotimer.nvim
Implement a pomodoro timer and stopwatch into Neovim in pure Lua.

## To-Do:
- [ ] Implement stopwatch

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
let g:pomodoro_time_work = 25
let g:pomodoro_time_break_short = 5
let g:pomodoro_time_break_long = 20
let g:pomodoro_timers_to_long_break = 4`
```
## Usage
| Command		| Description                                           |
|---------------|-------------------------------------------------------|
| :TomatoStart  | Starts the Pomodoro sessio                            |
| :TomatoStop   | Stops the Pomodoro session.                           |
| :TomatoStatus | Displays time remaining of current Pomodoro session   |
