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

local options = { }
for _, file in ipairs(files) do
  if vim.fn.isdirectory(directory_path .. "/" .. file) == 1 then
    if file:sub(1, 1) ~= "." then
      table.insert(options, file)
    end
  end
end

-- Function to display the menu and get user input
local function showMenu()
    print("Select an option:")
    for i, option in ipairs(options) do
        print(i .. ". " .. option)
    end

    while true do
        local choice = vim.fn.input("Enter the number of your choice: ")
        choice = tonumber(choice)

        if choice and choice >= 1 and choice <= #options then
            if choice == #options then
                print("Exiting...")
                return
            else
                print("You selected: " .. options[choice])
                -- Perform actions based on the selected option
                -- Add your code here
                return
            end
        else
            print("Invalid choice. Please enter a valid option.")
        end
    end
end

-- Call the function to display the menu
showMenu()
