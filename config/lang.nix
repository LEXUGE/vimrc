{ pkgs, ... }: {
  extraPackages = with pkgs; [ stylua black nixpkgs-fmt ];
  plugins.lsp = {
    enable = true;
  };

  plugins.nvim-autopairs.enable = true;

  plugins.treesitter = {
    # By default this uses nixGrammar and installs all grammars available.
    enable = true;
    indent = true;
  };

  plugins.conform-nvim = {
    enable = true;
    formatOnSave = {
      lspFallback = true;
      timeoutMs = 500;
    };

    formattersByFt = {
      nix = [ "nixpkgs_fmt" ];
      lua = [ "stylua" ];

      # Conform will run multiple formatters sequentially
      python = [ "black" ];

      # Use the "_" filetype to run formatters on filetypes that don't
      # have other formatters configured.
      "_" = [ "trim_whitespace" ];
    };
  };
}
