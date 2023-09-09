local M = {}

function ObsidianMoveFile()
  local current_buf = vim.api.nvim_get_current_buf()
  local full_path = vim.api.nvim_buf_get_name(current_buf)
  local directory_path = "/home/austin/Zettelkasten-v2"
  local files = vim.fn.readdir(directory_path)

  local options = { }
  for _, file in ipairs(files) do
    if vim.fn.isdirectory(directory_path .. "/" .. file) == 1 then
      if file:sub(1, 1) ~= "." then
        table.insert(options, file)
      end
    end
  end

  local function showMenu()
      print("Select Directory to move to:")
      for i, option in ipairs(options) do
          print(i .. ". " .. option)
      end

      while true do
          local choice = vim.fn.input("Enter the number of your choice: ")
          choice = tonumber(choice)

          if choice and choice >= 1 and choice <= #options then
              print("You selected: " .. options[choice])
              print(full_path)
              local filename = string.match(full_path, "[^/\\]+$")
              local path_to_place_file = directory_path .. "/" .. options[choice] .. "/" .. filename
              print(path_to_place_file)
              local success, errorMsg = os.rename(full_path, directory_path .. "/" .. options[choice] .. "/" .. filename)
              if success then
                print("File moved successfully, reloading file in new buffer.")
                vim.api.nvim_command("e " .. path_to_place_file)
              else
                print("Error moving file: " .. errorMsg)
              end
              return
          else
              print("Invalid choice. Please enter a valid option.")
          end
      end
  end

  showMenu()
end

return M





