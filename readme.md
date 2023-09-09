# Why?
I prefer to use neovim for all of my note taking, but I have recently stumbled into obsidian and i've been amazed at how powerful of a note taking application it is so I've started assembling my zettelkasten in it. Then I stumbled onto [Obsidian.nvim](), and realized it had everything I wanted, except for the ability to move files to a separate folder while editing it. The end goal of this repo is that the code here gets merged into the Obsidian.nvim project.

## Setup
### Lazy
```
{
    "austinwilcox/Obsidian-nvim-move-file",
    config=function()
      require("Obsidian-nvim-move-file").setup{}
    end
}
```

## Instruction
Once the package is loaded with lazy, you can now use the command: ObsidianMoveCurrentBuffer. Use this command in command mode when you are editing a file that you want to move to a different location. It currently only works with my home directory, that's a WIP item that I need to fix where I can supply the config option with Lazy and then load that so this becomes usable for other people.
