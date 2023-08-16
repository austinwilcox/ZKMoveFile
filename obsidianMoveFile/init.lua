-- local M = {}

-- function ObsidianMoveFile()
--   local currBuffer = vim.current.buffer
--   print(currBuffer)
--   print("Hello World")
-- end

-- ObsidianMoveFile()

-- return M
--
--
--

local test = vim.api.nvim_get_current_buf()
local full_path = vim.api.nvim_buf_get_name(test)
print(full_path)

local directory_path = "/home/austin/Zettelkasten-v2"
local files = vim.fn.readdir(directory_path)

for _, file in ipairs(files) do
  if vim.fn.isdirectory(directory_path .. "/" .. file) == 1 then
    if file:sub(1, 1) ~= "." then
      print(file)
    end
  end
end

-- Currently the script will will print the full path of the current file being edited in the buffer, and it will print out all directories that are direct children of the directory_path
-- What I now need to do, is supply the directories to telescope in a popup, and then allow the user to select which directory they want to move the file to
-- After the user has selected the directory, I then want to be able to move the file to that directory
