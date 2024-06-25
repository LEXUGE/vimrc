{ pkgs, ... }: {
  extraPackages = with pkgs; [ stylua black nixpkgs-fmt ];
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps = {
      silent = true;
      lspBuf = {
        "K" = "hover";
        "<leader>rn" = "rename";
      };
      # Integerate with telescoep.
      extra = [
        { key = "gd"; action.__raw = "require('telescope.builtin').lsp_definitions"; }
        { key = "gI"; action.__raw = "require('telescope.builtin').lsp_implementations"; }
        { key = "gr"; action.__raw = "require('telescope.builtin').lsp_references"; }
        { key = "<leader>ds"; action.__raw = "require('telescope.builtin').lsp_document_symbols"; }
        { key = "<leader>ws"; action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols"; }
      ];
    };
    # Declare extra capabilities, copied from kickstart.nvim
    capabilities = ''
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    '';
  };

  plugins.lsp = {
    servers = {
      # Nix LSP
      nil-ls.enable = true;

      # Rust LSP
      rust-analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };

      # Python LSP
      ruff.enable = true;
      ruff-lsp.enable = true;
    };
  };


  plugins.nvim-ufo = {
    enable = true;
    providerSelector = "function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end";
  };

  opts = {
    foldcolumn = "1";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;
  };

  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = [
        { name = "async_path"; }
        { name = "nvim_lsp_signature_help"; }
        {
          name = "nvim_lsp";
          keyword_length = 3;
        }
        {
          name = "nvim_lua";
          keyword_length = 2;
        }
        {
          name = "buffer";
          keyword_length = 2;
        }
      ];
      mapping.__raw = ''
        cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        })
      '';
    };
  };

  # plugins.rustaceanvim.enable = true;

  plugins = {
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lua.enable = true;
    cmp-buffer.enable = true;
    cmp-async-path.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
  };

  plugins.nvim-autopairs.enable = true;

  plugins.treesitter = {
    # By default this uses nixGrammar and installs all grammars available.
    enable = true;
    indent = true;
    incrementalSelection.enable = true;
  };

  # Formatting
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

  # Jump between LSP diagnostics.
  keymaps = [
    { mode = "n"; key = "zR"; action.__raw = "require('ufo').openAllFolds"; }
    { mode = "n"; key = "zM"; action.__raw = "require('ufo').closeAllFolds"; }
    { mode = "n"; key = "[d"; action.__raw = "vim.diagnostic.goto_prev"; options.desc = "Go to previous [D]iagnostic message"; }
    { mode = "n"; key = "]d"; action.__raw = "vim.diagnostic.goto_next"; options.desc = "Go to next [D]iagnostic message"; }
    { mode = "n"; key = "<leader>e"; action.__raw = "vim.diagnostic.open_float"; options.desc = "Show diagnostic [E]rror messages"; }
    { mode = "n"; key = "<leader>q"; action.__raw = "vim.diagnostic.setloclist"; options.desc = "Open diagnostic [Q]uickfix list"; }
  ];
}
