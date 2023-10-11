local popup = require('plenary.popup')
local move_file_win_id = nil
local move_file_bufnr = nil
local options = { }
local current_buf = nil

local M = {}

local function traverseFilePath(path, currentLayer)
  local files = vim.fn.readdir(path)
  local _, final = string.find(path, M.dir, 1, true)
  local parent_path = nil
  if final ~= nil and path ~= M.dir then
    parent_path = string.sub(path, final+2)
  end
  for _, file in ipairs(files) do
    if vim.fn.isdirectory(path .. "/" .. file) == 1 then
      if file:sub(1, 1) ~= "." then
        if parent_path ~= nil then
          table.insert(options, parent_path .. "/" .. file)
        else
          table.insert(options, file)
        end

        if M.layers == -1 or currentLayer < M.layers then
          traverseFilePath(path .. "/" .. file, currentLayer + 1)
        end
      end
    end
  end
end

local function create_window()
    local width =  60
    local height = 10
    local borderchars =  { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = vim.api.nvim_create_buf(false, false)

    local zk_move_cmd_win_id, win = popup.create(bufnr, {
        title = M.title,
        highlight = "ZKWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
    })

    vim.api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:ZKBorder"
    )

    return {
        bufnr = bufnr,
        win_id = zk_move_cmd_win_id,
    }
end

function M.ZKMoveCurrentBuffer()
  current_buf = vim.api.nvim_get_current_buf()

  traverseFilePath(M.dir, 0)

  local win_info = create_window()
  move_file_bufnr = win_info.bufnr
  move_file_win_id = win_info.win_id

  vim.api.nvim_win_set_option(move_file_win_id, "number", true)
  vim.api.nvim_buf_set_name(move_file_bufnr, "zk-move-file-menu")
  vim.api.nvim_buf_set_lines(move_file_bufnr, 0, #options, false, options)
  vim.api.nvim_buf_set_option(move_file_bufnr, "filetype", "zk-move-file")
  vim.api.nvim_buf_set_option(move_file_bufnr, "buftype", "acwrite")
  vim.api.nvim_buf_set_option(move_file_bufnr, "bufhidden", "delete")


  vim.api.nvim_buf_set_keymap(
    move_file_bufnr,
    "n",
    "q",
    "<Cmd>lua Close_menu()<CR>",
    { silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    move_file_bufnr,
    "n",
    "<ESC>",
    "<Cmd>lua Close_menu()<CR>",
    { silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    move_file_bufnr,
    "n",
    "<CR>",
    "<Cmd>lua Select_menu_item()<CR>",
    {}
  )
  vim.cmd(
    string.format(
      "autocmd BufModifiedSet <buffer=%s> set nomodified",
      move_file_bufnr
    )
  )
end

function Select_menu_item()
  local full_path = vim.api.nvim_buf_get_name(current_buf)
  local choice = vim.fn.line(".")
  local directory_path = M.dir
  local filename = string.match(full_path, "[^/\\]+$")
  local path_to_place_file = directory_path .. "/" .. options[choice] .. "/" .. filename
  local success, errorMsg = os.rename(full_path, directory_path .. "/" .. options[choice] .. "/" .. filename)
  Close_menu()
  if success then
    print("File moved successfully to " .. options[choice] .. ", reloading file in new buffer.")
    vim.api.nvim_command("e " .. path_to_place_file)
  else
    print("Error moving file: " .. errorMsg)
  end
end

function Close_menu()
  vim.api.nvim_win_close(move_file_win_id, true)

  move_file_bufnr = nil
  move_file_win_id = nil
end


local commands = {
  ZKMoveCurrentBuffer = { func = M.ZKMoveCurrentBuffer, opts = { nargs = 0} }
}

function M.setup(opts)
  M.dir = opts.dir
  M.title = opts.title or "ZK Move Current Buffer"
  M.layers = opts.layers or 0
  for command_name, command_config in pairs(commands) do
    local func = function()
      command_config.func()
    end

    vim.api.nvim_create_user_command(command_name, func, command_config.opts)
  end
end

--TESTING LOCALLY
--luafile init.lua
-- M.setup({ dir= "/home/austin/Zettelkasten-v2", title= "Test", layers= 1 })
-- M.ZKMoveCurrentBuffer()
--END TESTING

return M
