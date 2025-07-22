{
  buildVimPlugin,
  fetchFromGitHub,
  lib,
}:
final: prev: {
  typst-preview-nvim = (
    buildVimPlugin {
      name = "typst-preview.nvim";
      src = fetchFromGitHub {
        owner = "chomosuke";
        repo = "typst-preview.nvim";
        rev = "v1.3.2";
        hash = "sha256-BGNgGpg6ixvQ7bZl1pFRi3B1lqKDZqI4Ix3gFQVFxXg=";
      };
    }
  );
  # telescope-nvim = (buildVimPlugin {
  #   name = "telescope.nvim";
  #   src = fetchFromGitHub {
  #     owner = "nvim-telescope";
  #     repo = "telescope.nvim";
  #     rev = "bc4e7e450397970ab741d0f489e370ec4ce4d57c";
  #     hash = "sha256-aGwF0I4bpo5imff4I7cW8qvO97uY3+7vu/LbAENdMkc=";
  #   };
  # });
}
