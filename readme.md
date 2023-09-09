# Why?
I prefer to use neovim for all of my note taking, but I have recently stumbled into obsidian and i've been amazed at how powerful of a note taking application it is so I've started assembling my zettelkasten in it. Then I stumbled onto [Obsidian.nvim](https://github.com/epwalsh/obsidian.nvim#notes-on-configuration), and realized it had everything I wanted, except for the ability to move files to a separate folder while editing it. The end goal of this repo is that the code here gets merged into the Obsidian.nvim project.

## Setup
### Lazy
```
{
    "austinwilcox/Obsidian-nvim-move-file",
    config=function()
      require("Obsidian-nvim-move-file").setup{
        dir=/full/path/to/obsidian/directory       
      }
    end
}
```

## Instruction
Once the package is loaded with lazy, you can now use the command: ObsidianMoveCurrentBuffer. Use this command in command mode when you are editing a file that you want to move to a different location.

## TODO
1. Recursively load all directories within the obsidian vault - currently only loads surface level folders
2. Fix output when moving a file to the selected directory
3. Use Plenary instead of vim.input
