{ pkgs, ... }: {
  extraConfigLuaPre = (builtins.readFile ./pre.lua);
  extraConfigLua = (builtins.readFile ./extra.lua);

  extraPackages = [ pkgs.xclip pkgs.inkscape pkgs.git ];

  imports = [
    # Configuration related to movements
    ./movements.nix
    # Integration of nvim with other tools
    ./tools.nix
    # General "better-default"
    ./general.nix
    # Language supports
    ./lang.nix
    # Telescope configs
    ./telescope.nix
  ];
}
