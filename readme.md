# Why?
I prefer to use neovim for all of my note taking, but I have recently stumbled into obsidian and i've been amazed at how powerful of a note taking application it is so I've started assembling my [Zettelkasten](https://en.wikipedia.org/wiki/Zettelkasten) in it. Then I stumbled onto [Obsidian.nvim](https://github.com/epwalsh/obsidian.nvim#notes-on-configuration), and realized it had everything I wanted, except for the ability to move files to a separate folder while editing it. The end goal of this repo is that the code here gets merged into the Obsidian.nvim project.

## Setup
There are 3 options you can supply to ZKMoveFile.
Those are dir, title, and layers. dir is the only required one, whereas layers will determine how many folders deep to travel, and title is the title of the plenary popup window.

layers: Default is 0. 0 will be just the current level that you supply with dir, 1 will go 1 layer deeper than that, etc. If you want to recursively search all subdirectories supply -1.

title: Default is "ZK Move Current Buffer", but you can supply whatever you would like.

dir: The root directory of your Zettelkasten. 

### Lazy
```
{
    "austinwilcox/ZKMoveFile",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config=function()
      require("ZKMoveFile").setup{
        dir=/full/path/to/zettelkasten,
        title='ZK Directories',
        layers=0
      }
    end
}
```

## Instruction
Once the package is loaded with lazy, you can now use the command ```ZKMoveCurrentBuffer```. Use this command in command mode when you are editing a file that you want to move to a different location within your Zettelkasten.

## TODO
1. - [x] Recursively load all directories within the ~~obsidian~~Zettelkasten vault - currently only loads surface level folders
2. - [x] Fix output when moving a file to the selected directory
3. - [x] Use Plenary instead of vim.input
4. - [ ] Merge into obsidian.nvim
