{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      ui-select.enable = true;
    };
  };

  # Two important keymaps to use while in Telescope are:
  # - Insert mode: <c-/>
  # - Normal mode: ?
  keymaps = [
    { key = "<leader>sh"; action = "<cmd>Telescope help_tags <CR>"; mode = "n"; options.desc = "[S]earch [H]elp"; }
    { key = "<leader>sk"; action = "<cmd>Telescope keymaps <CR>"; mode = "n"; options.desc = "[S]earch [K]eymaps"; }
    { key = "<leader>sf"; action = "<cmd>Telescope find_files <CR>"; mode = "n"; options.desc = "[S]earch [F]iles"; }
    { key = "<leader>ss"; action = "<cmd>Telescope builtin <CR>"; mode = "n"; options.desc = "[S]earch [S]elect Telescope"; }
    { key = "<leader>sw"; action = "<cmd>Telescope grep_string <CR>"; mode = "n"; options.desc = "[S]earch current [W]ord"; }
    { key = "<leader>sg"; action = "<cmd>Telescope live_grep <CR>"; mode = "n"; options.desc = "[S] earch by [G] rep"; }
    { key = "<leader>sd"; action = "<cmd>Telescope diagnostics <CR>"; mode = "n"; options.desc = "[S] earch [D] iagnostics"; }
    { key = "<leader>sr"; action = "<cmd>Telescope resume <CR>"; mode = "n"; options.desc = "[S]earch [R] esume"; }
    { key = "<leader>s."; action = "<cmd>Telescope oldfiles <CR>"; mode = "n"; options.desc = "[S]earch Recent Files (\".\" for repeat)"; }
    { key = "<leader><leader>"; action = "<cmd>Telescope buffers <CR>"; mode = "n"; options.desc = "[ ] Find existing buffers"; }
  ];
}







