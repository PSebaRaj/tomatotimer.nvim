vim.g.tomatotimer_time_work = 25
vim.g.tomatotimer_time_break_short = 5
vim.g.tomatotimer_time_break_long = 20
vim.g.tomatotimer_timers_to_long_break = 4

local tomatotimer_state = 'stopped'
local tomatotimer_work_started_at = 0
local tomatotimer_break_started_at = 0
local tomatotimer_timers_completed = 0
local tomatotimer_uv_timer = nil

local function tomatotimer_time_break()
    if tomatotimer_timers_completed == 0 then
        return vim.g.tomatotimer_time_break_long
    else
        return vim.g.tomatotimer_time_break_short
    end
end

local function tomatotimer_time_remaining(duration, start)
    local seconds = duration * 60 - os.difftime(os.time(), start)
    if math.floor(seconds / 60) >= 60 then
        return os.date('!%0H:%0M:%0S', seconds)
    else
        return os.date('!%0M:%0S', seconds)
    end
end

local display_tomatotimer_completed_menu
local function start_tomatotimer()
    if tomatotimer_state ~= 'started' then
        local work_milliseconds = vim.g.tomatotimer_time_work * 60 * 1000
        tomatotimer_uv_timer:start(work_milliseconds, 0, vim.schedule_wrap(display_tomatotimer_completed_menu))
        tomatotimer_work_started_at = os.time()
        tomatotimer_state = 'started'
    end
end

local display_break_completed_menu
local function start_break()
    if tomatotimer_state == 'started' then
        tomatotimer_timers_completed = (tomatotimer_timers_completed + 1) % vim.g.tomatotimer_timers_to_long_break
        local break_milliseconds = tomatotimer_time_break() * 60 * 1000
        tomatotimer_uv_timer:start(break_milliseconds, 0, vim.schedule_wrap(display_break_completed_menu))
        tomatotimer_break_started_at = os.time()
        tomatotimer_state = 'break'
    end
end

local Tomato = {}

function Tomato.start()
    if tomatotimer_state == 'stopped' then
        tomatotimer_uv_timer = vim.loop.new_timer()
        start_tomatotimer()
    end
end

function Tomato.statusline()
    if tomatotimer_state == 'stopped' then
        return 'ﮫ (inactive)'
    elseif tomatotimer_state == 'started' then
        return '羽' .. tomatotimer_time_remaining(vim.g.tomatotimer_time_work, tomatotimer_work_started_at)
    else
        local break_minutes = tomatotimer_time_break()
        return 'ﲊ ' .. tomatotimer_time_remaining(break_minutes, tomatotimer_break_started_at)
    end
end

function Tomato.status()
    print(Tomato.statusline())
end

function Tomato.stop()
    if tomatotimer_state ~= 'stopped' then
        tomatotimer_uv_timer:stop()
        tomatotimer_uv_timer:close()
        tomatotimer_state = 'stopped'
    end
end

function Tomato.setup(tbl)
    if tbl == nil or #tbl == 0 then
      return
    end

    if tbl.time_work then
        vim.g.tomatotimer_time_work = tbl.time_work
    end

    if tbl.time_break_short then
        vim.g.tomatotimer_time_break_short = tbl.time_break_short
    end

    if tbl.time_break_long then
        vim.g.tomatotimer_time_break_long = tbl.time_break_long
    end

    if tbl.timers_to_long_break then
        vim.g.tomatotimer_timers_to_long_break = tbl.timers_to_long_break
    end
end

local Menu = require('nui.menu')
local event = require('nui.utils.autocmd').event

display_tomatotimer_completed_menu = function()
    local popup_options = {
        border = {
            style = 'rounded',
            text = {
                top_align = 'left',
                top = '[Tomato Completed]'
            },
            padding = { 1, 3 },
        },
        position = '50%',
        size = {
            width = '25%',
        },
        opacity = 1,
    }

    local menu_options = {
        keymap = {
            focus_next = { 'j', '<Down>', '<Tab>' },
            focus_prev = { 'k', '<Up>', '<S-Tab>' },
            close = { '<Esc>', '<C-c>' },
            submit = { '<CR>', '<Space>' },
        },
        lines = { Menu.item('Take break'), Menu.item('Quit') },
        on_close = Tomato.stop,
        on_submit = function(item)
            if item.text == 'Quit' then
                Tomato.stop()
            else
                start_break()
            end
        end
    }
    local menu = Menu(popup_options, menu_options)
    menu:mount()
    menu:on(event.BufLeave, function()
        Tomato.stop()
        menu:unmount()
    end, { once = true })
    menu:map('n', 'b', function()
        start_break()
        menu:unmount()
    end, { noremap = true })
    menu:map('n', 'q', function()
        Tomato.stop()
        menu:unmount()
    end, { noremap = true })
end

display_break_completed_menu = function()
    local popup_options = {
        border = {
            style = 'rounded',
            text = {
                top_align = 'left',
                top = '[Break Completed]'
            },
            padding = { 1, 3 },
        },
        position = '50%',
        size = {
            width = '25%',
        },
        opacity = 1,
    }

    local menu_options = {
        keymap = {
            focus_next = { 'j', '<Down>', '<Tab>' },
            focus_prev = { 'k', '<Up>', '<S-Tab>' },
            close = { '<Esc>', '<C-c>' },
            submit = { '<CR>', '<Space>' },
        },
        lines = { Menu.item('Start pomodoro'), Menu.item('Quit') },
        on_close = Tomato.stop,
        on_submit = function(item)
            if item.text == 'Quit' then
                Tomato.stop()
            else
                start_tomatotimer()
            end
        end
    }

    local menu = Menu(popup_options, menu_options)
    menu:mount()
    menu:on(event.BufLeave, function()
        Tomato.stop()
        menu:unmount()
    end, { once = true })
    menu:map('n', 'p', function()
        start_tomatotimer()
        menu:unmount()
    end, { noremap = true })
    menu:map('n', 'q', function()
        Tomato.stop()
        menu:unmount()
    end, { noremap = true })
end

return Tomato
