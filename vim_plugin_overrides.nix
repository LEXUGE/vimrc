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
        owner = "floaterest";
        repo = "typst-preview.nvim";
        rev = "ef8a064a592ce7fbf50d0f4ec18436f5ade98a3b";
        hash = "sha256-+6awyJNp4XShEyzvz8isu63xeUaplGNp2e8AwuuHoOg=";
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
