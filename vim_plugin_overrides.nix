{ buildVimPlugin, fetchFromGitHub }:
final: prev: {
  telescope-nvim = (buildVimPlugin {
    name = "telescope.nvim";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "bc4e7e450397970ab741d0f489e370ec4ce4d57c";
      hash = "sha256-aGwF0I4bpo5imff4I7cW8qvO97uY3+7vu/LbAENdMkc=";
    };
  });
}
