{ pkgs, lib, ... }: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "telescope-tabs";
      src = pkgs.fetchFromGitHub {
        owner = "LukasPietzschmann";
        repo = "telescope-tabs";
        rev = "0a678eefcb71ebe5cb0876aa71dd2e2583d27fd3";
        hash = "sha256-IvxZVHPtApnzUXIQzklT2C2kAxgtAkBUq3GNxwgPdPY=";
      };
    })
  ];

  plugins.telescope = {
    enable = true;
    settings.defaults.mappings = {
      n."d".__raw = "require('telescope.actions').delete_buffer";
      i."<C-d>".__raw = "require('telescope.actions').delete_buffer";
    };
    extensions = {
      fzf-native.enable = true;
      ui-select.enable = true;
      file-browser = {
        enable = true;
        settings = {
          dir_icon = "D";
          prompt_path = true;
          mappings.i = {
            "<A-g>" = "fb_open_using(require(\"telescope.builtin\").live_grep)";
            "<A-f>" = "fb_open_using(require(\"telescope.builtin\").find_files)";
          };
        };
      };
    };
  };

  # Two important keymaps to use while in Telescope are:
  # - Insert mode: <c-/>
  # - Normal mode: ?
  keymaps = [
    { key = "<leader>sh"; action = "<cmd>Telescope help_tags <CR>"; mode = "n"; options.desc = "[S]earch [H]elp"; }
    { key = "<leader>sk"; action = "<cmd>Telescope keymaps <CR>"; mode = "n"; options.desc = "[S]earch [K]eymaps"; }
    # git_files always launch from the .gitignore, so behaves pretty much like a "search project" functionality.
    { key = "<leader>sp"; action = "<cmd>Telescope git_files <CR>"; mode = "n"; options.desc = "[S]earch Git [P]roject"; }
    {
      key = "<leader>sf";
      action.__raw = "function()
            local builtin = require(\"telescope.builtin\")
            local utils = require(\"telescope.utils\")
            builtin.find_files({ cwd = utils.buffer_dir() })
          end
        ";
      mode = "n";
      options.desc = "[S]earch [F]iles";
    }
    { key = "<leader>ss"; action = "<cmd>Telescope builtin <CR>"; mode = "n"; options.desc = "[S]earch [S]elect Telescope"; }
    { key = "<leader>se"; action = "<cmd>Telescope session-lens <CR>"; mode = "n"; options.desc = "[S]ession"; }
    { key = "<leader>sw"; action = "<cmd>Telescope grep_string <CR>"; mode = "n"; options.desc = "[S]earch current [W]ord"; }
    {
      key = "<leader>sg";
      action.__raw = "function()
            local builtin = require(\"telescope.builtin\")
            local utils = require(\"telescope.utils\")
            builtin.live_grep({ cwd = utils.buffer_dir() })
          end
        ";
      mode = "n";
      options.desc = "[S]earch by [G]rep";
    }
    { key = "<leader>sd"; action = "<cmd>Telescope diagnostics <CR>"; mode = "n"; options.desc = "[S]earch [D]iagnostics"; }
    { key = "<leader>sr"; action = "<cmd>Telescope resume <CR>"; mode = "n"; options.desc = "[S]earch [R]esume"; }
    { key = "<leader>s."; action = "<cmd>Telescope oldfiles <CR>"; mode = "n"; options.desc = "[S]earch Recent Files (\".\" for repeat)"; }
    { key = "<leader>b"; action.__raw = "function() require(\"telescope.builtin\").buffers({sort_lastused = true}) end"; mode = "n"; options.desc = "Find existing [b]uffers"; }
    {
      key = "<leader>/";
      action.__raw = "function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        local builtin = require 'telescope.builtin'
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end";
      mode = "n";
      options.desc = "[/] Fuzzily search in current buffer";
    }
    { key = "<leader><leader>"; action = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>"; mode = "n"; options.desc = "File Browser"; }
    { key = "<leader>t"; action = "<cmd>Telescope telescope-tabs list_tabs<CR>"; mode = "n"; options.desc = "[T]abs"; }
    { key = "<leader>y"; action = "<cmd>Telescope yank_history<CR>"; mode = "n"; options.desc = "[Y]anky Ring"; }
  ];
}
