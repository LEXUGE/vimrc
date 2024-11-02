{ pkgs, ... }: {
  opts = {
    # Make line numbers default
    number = true;
    # Enable relative line number
    relativenumber = true;

    # Enable mouse mode, can be useful for resizing splits for example!
    mouse = "a";
    # Don't show mode as it's already displayed at the status bar.
    showmode = false;

    # Make the clipboard share witht the system one.
    clipboard = "unnamedplus";

    # All wrapped lines will be indented.
    breakindent = true;

    # Save the undo history.
    undofile = true;

    # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    ignorecase = true;
    smartcase = true;

    # Keep sign column on by default.
    signcolumn = "yes";

    # Decrease update time
    updatetime = 250;

    # Decrease mapped sequence wait time.
    # Display which-key popup sooner.
    timeoutlen = 300;

    # Split the window to the right of the current window by default.
    # This has to be used by :vsp to take effect.
    splitright = true;
    # Split the window below the current by default.
    # This has to be used together with :sp.
    splitbelow = true;

    # Sets how neovim will display certain whitespace characters in the editor.
    #   See `:help 'list'`
    #   and `:help 'listchars'`
    list = true;
    listchars = { tab = "» "; trail = "·"; nbsp = "␣"; };

    # Preview substitutions live, as you type!
    inccommand = "split";

    # Show which line your cursor is on
    cursorline = true;

    # Minimal number of screen lines to keep above and below the cursor.
    scrolloff = 10;

    # Disable the highlight after pressing <Esc> in Normal mode.
    hlsearch = true;

    # allow cursor to move anywhere in the visual block mode. This is good for "end of the line" edit.
    virtualedit = "block";

    # Spell check
    spelllang = "en_us";
    spell = true;
  };

  # Highlight when we copy the text.
  autoCmd = [{
    event = "TextYankPost";
    desc = "Highlight when copying text";
    group = "highlight-yank";
    callback."__raw" = "function() vim.highlight.on_yank() end";
  }];
  autoGroups.highlight-yank.clear = true;

  # yank ring/kill ring
  plugins.yanky = {
    enable = true;
    enableTelescope = true;
    # We could move the cursor around and still be able to cycle through the ring
    settings.ring.cancel_event = "update";
  };

  colorschemes.gruvbox.enable = true;
  plugins.lightline = {
    enable = true;
    settings.colorscheme = "powerline";
  };

  plugins.sleuth.enable = true;

  plugins.which-key = {
    enable = true;
  };

  # Don't include fold as it breaks the auto-session occasionally.
  # https://github.com/rmagatti/auto-session/issues/109
  opts.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions";
  plugins.auto-session = {
    enable = true;
    settings.auto_create = {
      __raw = ''
        function()
          local cmd = 'git rev-parse --is-inside-work-tree'
          return vim.fn.system(cmd) == 'true\n'
        end,
      '';
    };
  };

  # Comment an area of code fast.
  plugins.comment.enable = true;
  # Highlight TODO and FIXME and NOTE in comments.
  plugins.todo-comments.enable = true;

  extraPlugins = [
    # Use emacs style binding in insert and command line mode
    pkgs.vimPlugins.vim-rsi
    # Add/remove brackets
    pkgs.vimPlugins.nvim-surround
  ];

  keymaps = [
    # Tab management
    { mode = "n"; key = "<A-l>"; action = ":tabn<CR>"; }
    { mode = "n"; key = "<A-h>"; action = ":tabp<CR>"; }
    { mode = "n"; key = "g<Tab>"; action.__raw = "function() require('telescope-tabs').go_to_previous() end"; }

    # Use emacs like keymap in insert mode for navigation
    { mode = "i"; key = "<C-p>"; action = "<Up>"; }
    { mode = "i"; key = "<C-n>"; action = "<Down>"; }

    # Disable search highlight after the Esc.
    { action = "<cmd>nohlsearch<CR>"; key = "<Esc>"; mode = "n"; }

    # Yanky ring
    {
      mode = "n";
      key = "<C-p>";
      action = "<Plug>(YankyPreviousEntry)";
    }
    {
      mode = "n";
      key = "<C-n>";
      action = "<Plug>(YankyNextEntry)";
    }
    {
      mode = [ "n" "x" ];
      key = "p";
      action = "<Plug>(YankyPutAfter)";
    }
    {
      mode = [ "n" "x" ];
      key = "P";
      action = "<Plug>(YankyPutBefore)";
    }
  ];
}
