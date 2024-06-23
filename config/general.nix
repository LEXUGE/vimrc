{
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
  };

  # Disable the highlight after pressing <Esc> in Normal mode.
  opts.hlsearch = true;
  keymaps = [{ action = "<cmd>nohlsearch<CR>"; key = "<Esc>"; mode = "n"; }];

  # Highlight when we copy the text.
  autoCmd = [{
    event = "TextYankPost";
    desc = "Highlight when copying text";
    group = "highlight-yank";
    callback."__raw" = "function() vim.highlight.on_yank() end";
  }];
  autoGroups.highlight-yank.clear = true;

}
