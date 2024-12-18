{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.julia-vim ];
  extraPackages = with pkgs; [
    stylua
    black
    nixfmt-rfc-style
  ];
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
        {
          key = "gd";
          action.__raw = "require('telescope.builtin').lsp_definitions";
        }
        {
          key = "gI";
          action.__raw = "require('telescope.builtin').lsp_implementations";
        }
        {
          key = "gr";
          action.__raw = "require('telescope.builtin').lsp_references";
        }
        {
          key = "<leader>ds";
          action.__raw = "require('telescope.builtin').lsp_document_symbols";
        }
        {
          key = "<leader>ws";
          action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
        }
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
      nil_ls.enable = true;

      # Rust LSP
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };

      # Python LSP
      pyright.enable = true;
    };
  };

  plugins.nvim-ufo = {
    enable = true;
    settings.provider_selector = "function(bufnr, filetype, buftype)
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
    settings.indent.enable = true;
    settings.incremental_selection = {
      enable = true;
      keymaps = {
        # tree sitter start
        init_selection = "<Leader>tss";
        node_incremental = "<Leader>tsi";
        node_decremental = "<Leader>tsd";
        scope_incremental = "<Leader>tsc";
      };
    };
    settings.highlight.enable = true;
  };

  # Display the context (i.e. the function signature when in the body of a function)
  plugins.treesitter-context = {
    enable = true;
  };

  plugins.treesitter-textobjects = {
    enable = true;
    select = {
      enable = true;
      lookahead = true;
      keymaps = {
        "af".query = "@function.outer";
        "if".query = "@function.inner";
        "ab".query = "@block.outer";
        "ib".query = "@block.inner";
        "ip".query = "@parameter.inner";
        "la".query = "@assignment.lhs";
        "ra".query = "@assignment.rhs";
      };
    };

    move = {
      enable = true;
      setJumps = true;
      gotoNextStart = {
        "]f".query = "@function.outer";
        "]b".query = "@block.inner";
        "]p".query = "@parameter.inner";
      };

      gotoPreviousStart = {
        "[f".query = "@function.outer";
        "[b".query = "@block.inner";
        "[p".query = "@parameter.inner";
      };
    };
  };

  # Formatting
  plugins.conform-nvim = {
    enable = true;
    settings.format_on_save = {
      lspFallback = true;
      timeoutMs = 500;
    };

    settings.formatters_by_ft = {
      nix = [ "nixfmt" ];
      lua = [ "stylua" ];

      # Conform will run multiple formatters sequentially
      python = [ "black" ];

      # Use the "_" filetype to run formatters on filetypes that don't
      # have other formatters configured.
      "_" = [ "trim_whitespace" ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "zR";
      action.__raw = "require('ufo').openAllFolds";
    }
    {
      mode = "n";
      key = "zM";
      action.__raw = "require('ufo').closeAllFolds";
    }
    # Jump between LSP diagnostics.
    {
      mode = "n";
      key = "[d";
      action.__raw = "vim.diagnostic.goto_prev";
      options.desc = "Go to previous [D]iagnostic message";
    }
    {
      mode = "n";
      key = "]d";
      action.__raw = "vim.diagnostic.goto_next";
      options.desc = "Go to next [D]iagnostic message";
    }
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "vim.diagnostic.open_float";
      options.desc = "Show diagnostic [E]rror messages";
    }
    {
      mode = "n";
      key = "<leader>q";
      action.__raw = "vim.diagnostic.setloclist";
      options.desc = "Open diagnostic [Q]uickfix list";
    }
    # Treesitter jumps
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = ";";
      action.__raw = "require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = ",";
      action.__raw = "require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move_opposite";
    }
    # Zotero citing
    {
      mode = "n";
      key = "<leader>z";
      action.__raw = "function() vim.api.nvim_put({zotero_cite()}, \"\", true, true) end";
      options = {
        noremap = true;
        silent = true;
        desc = "Open [Z]otero citing search";
      };
    }
  ];
}
