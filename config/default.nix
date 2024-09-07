{ pkgs, ... }: {
  extraConfigLuaPre = (builtins.readFile ./pre.lua);

  extraPackages = [ pkgs.xclip ];

  imports = [
    ./movements.nix
    ./general.nix
    ./lang.nix
    ./telescope.nix
  ];

  colorschemes.gruvbox.enable = true;
  plugins.lightline = {
    enable = true;
    colorscheme = "powerline";
  };

  plugins.sleuth.enable = true;
  # Comment an area of code fast.
  plugins.comment.enable = true;
  # Highlight TODO and FIXME and NOTE in comments.
  plugins.todo-comments.enable = true;

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

  plugins.which-key = {
    enable = true;
  };

  plugins.auto-session = {
    enable = true;
    autoSession.allowedDirs = [ "~/Documents/" ];
  };
}
