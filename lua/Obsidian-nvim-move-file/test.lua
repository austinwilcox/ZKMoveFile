local directory_path = "/home/austin/Zettelkasten-v2"
local options = {}
--Layers at -1 will search all subdirectories, 0 will only search the directory passed in
--Then any number above 0 will just go one layers deeper
local layers = 1

local function recursiveFilePath(path, currentLayer)
  local files = vim.fn.readdir(path)
  local _, final = string.find(path, directory_path, 1, true)
  local parent_path = nil
  if final ~= nil then
    parent_path = string.sub(path, final+1)
  end
  for _, file in ipairs(files) do
    --TODO: Make this a recursive function to get all subdirectories
    if vim.fn.isdirectory(path .. "/" .. file) == 1 then
      if file:sub(1, 1) ~= "." then
        if parent_path ~= nil then
          print(parent_path .. "/" .. file)
          table.insert(options, parent_path .. "/" .. file)
        else
          print(file)
          table.insert(options, file)
        end

        if layers == -1 or currentLayer < layers then
          recursiveFilePath(path .. "/" .. file, currentLayer + 1)
        end
      end
    end
  end
end

recursiveFilePath(directory_path, 0)
