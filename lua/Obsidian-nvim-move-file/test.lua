--NOTE: luafile test.lua is how you run this file

local popup = require("plenary.popup")

local function create_window()
    local width =  60
    local height = 10
    local borderchars =  { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = vim.api.nvim_create_buf(false, false)

    local obsidian_move_cmd_win_id, win = popup.create(bufnr, {
        title = "Directories",
        highlight = "ObsidianWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
    })

    vim.api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:ObsidianBorder"
    )

    return {
        bufnr = bufnr,
        win_id = obsidian_move_cmd_win_id,
    }
end

local contents = {"Test this out", "Test this out too"}
win_info = create_window()

vim.api.nvim_buf_set_lines(win_info.bufnr, 0, #contents, false, contents)
vim.api.nvim_buf_set_keymap(
    win_info.bufnr,
    "n",
    "<CR>",
    "<Cmd>lua select_menu_item()<CR>",
    {}
)

function select_menu_item()
    -- log.trace("cmd-ui#select_menu_item()")
    local cmd = vim.fn.line(".")
  print(cmd)
    -- close_menu(true)
    -- local answer = vim.fn.input("Terminal index (default to 1): ")
    -- if answer == "" then
    --     answer = "1"
    -- end
    -- local idx = tonumber(answer)
    -- if idx then
    --     term.sendCommand(idx, cmd)
    -- end
end

function close_menu() 
    vim.api.nvim_win_close(Harpoon_win_id, true)

    Harpoon_win_id = nil
    Harpoon_bufh = nil
end
