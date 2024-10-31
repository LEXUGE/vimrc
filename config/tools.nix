{ pkgs, lib, ... }: {
  plugins.gitsigns = {
    enable = true;
    settings = {
      signs = {
        add.text = "+";
        change.text = "~";
        delete.text = "_";
        topdelete.text = "‾";
        changedelete.text = "~";
      };
    };
  };

  plugins.diffview.enable = true;

  # Required by illustrate.nvim
  plugins.notify.enable = true;
  # Inkscape integration
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "illustrate.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "LEXUGE";
        repo = "illustrate.nvim";
        rev = "65c27c1cfcb9da31fafa29199aa24b4381439279";
        hash = "sha256-L8KIwkaIxSnLn7QWh/mQ8Zb0BFHis6T/or2PBoLCdV0=";
      };
    })
  ];

  keymaps = [
    { key = "<leader>is"; action.__raw = "function() require(\"illustrate\").create_and_open_svg() end"; mode = "n"; options.desc = "Create and open a new [S]VG file with provided name."; }
    { key = "<leader>io"; action.__raw = "function() require(\"illustrate\").open_under_cursor() end"; mode = "n"; options.desc = "[O]pen file under cursor (or file within environment under cursor)."; }
    { key = "<leader>if"; action.__raw = "function() require(\"illustrate.finder\").search_and_open() end"; mode = "n"; options.desc = "Use telescope to [F]ind and open illustrations in default app."; }
    { key = "<leader>ic"; action.__raw = "function() require(\"illustrate.finder\").search_create_copy_and_open() end"; mode = "n"; options.desc = "Use telescope to search existing file, [C]opy it with new name, and open it in default app."; }
  ];
}
