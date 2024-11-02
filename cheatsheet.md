# File Browser
## Modify
- Create file (trailing path separator to create a folder): <kbd>A-c</kbd>
- Delete file (use with selection): <kbd>A-d</kbd>
- Rename file: <kbd>A-r</kbd>
## Navigation
- Goto parent folder: <kbd>C-g</kbd>
- Goto current working directory: <kbd>C-w</kbd>
## Selection
- Toggle all: <kbd>C-s</kbd>
- Toggle current entry: <kbd>Tab</kbd>

# Vim basics
## Navigation
- Scroll other windows without shifting focus:
## Command line
- Just use the emacs keybindings. Though <kbd>M-b</kbd> doesn't work in command line mode.
## Manage buffers
- Use the telescope buffer manager (<kbd> b</kbd>). And use <kbd>d</kbd> or <kbd>C-d</kbd> in insert mode to delete the buffer.
## Tab pages
- Use the telescope tab manager (<kbd> t</kbd>). Default keybindings are given in [telescope-tabs](https://github.com/LukasPietzschmann/telescope-tabs).

# NeoVim Concepts
## Variables and options
Variables are user defined. Options are predefined and structured. Just like how attrset and options differ in nixpkgs!

- `vim.opt` sets the both global and local version of an option (if possible).
- `vim.opt_local/vim.opt_global` sets the global/local option only (provided the given option is global/local).
- `vim.o` don't use because it decides the scope (window/buffer/tab) of the variable that you want to set automatically.
