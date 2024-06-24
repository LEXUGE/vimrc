{ pkgs, ... }: {
  extraPackages = with pkgs; [ hackgen-nf-font stylua black nixpkgs-fmt ];
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps = {
      silent = true;
      lspBuf = {
        "K" = "hover";
        "<leader>rn" = "rename";
      };
      extra = [
        { key = "gd"; action.__raw = "require('telescope.builtin').lsp_definitions"; }
        { key = "gI"; action.__raw = "require('telescope.builtin').lsp_implementations"; }
        { key = "gr"; action.__raw = "require('telescope.builtin').lsp_references"; }
        { key = "<leader>ds"; action.__raw = "require('telescope.builtin').lsp_document_symbols"; }
        { key = "<leader>ws"; action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols"; }
      ];
    };
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
      rust-analyzer.enable = true;

      # Python LSP
      ruff.enable = true;
      ruff-lsp.enable = true;
    };
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
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        })
      '';
    };
  };
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
