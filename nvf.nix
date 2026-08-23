{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        preventJunkFiles = true;

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          enableDAP = true;

          nix = {
            enable = true;
            lsp.servers = ["nixd"];
            format.type = ["alejandra"];
          };

          python = {
            enable = true;
            lsp.servers = ["basedpyright" "ruff"];
            format.type = ["ruff-fix"];
            extraDiagnostics.types = ["mypy"];
          };

          clang = {
            enable = true;
            lsp.servers = ["clangd"];
            format.type = ["clang-format"];
          };
        };

        treesitter.enable = true;
        treesitter.context.enable = true;
        telescope.enable = true;

        dashboard.dashboard-nvim = {
          enable = true;
          setupOpts.config.header = [
            "██████████████████████"
            "██░░░░░░██████░░░░░░██"
            "██░░    ██████    ░░██"
            "██░░    ██████    ░░██"
            "████████      ████████"
            "█████            █████"
            "█████            █████"
            "█████    ████    █████"
            "█████    ████    █████"
            "██████████████████████"
            ""
          ];
        };

        statusline.lualine.enable = true;
        visuals.nvim-web-devicons.enable = true;
        autocomplete.nvim-cmp.enable = true;
        formatter.conform-nvim.enable = true;
        lineNumberMode = "number";

        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          trouble.enable = true;
          lspSignature.enable = true;
        };

        debugger.nvim-dap = {
          enable = true;
          ui.enable = true;
        };

        snippets.luasnip.enable = true;
        autopairs.nvim-autopairs.enable = true;

        filetree.nvimTree.enable = true;
        tabline.nvimBufferline.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
        };

        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };

        binds.whichKey.enable = true;

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          fastaction.enable = true;
        };

        utility = {
          surround.enable = true;
          diffview-nvim.enable = true;
          motion.leap.enable = true;
        };

        notes.todo-comments.enable = true;
        comments.comment-nvim.enable = true;

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };

        extraPackages = with pkgs; [
          ripgrep
          fd
          gnumake
          cmake
          gdb
        ];

        keymaps = [
          {
            key = "<leader>ff";
            mode = "n";
            silent = true;
            action = "<cmd>Telescope find_files<cr>";
            desc = "Find files";
          }
          {
            key = "<leader>fg";
            mode = "n";
            silent = true;
            action = "<cmd>Telescope live_grep<cr>";
            desc = "Grep";
          }
          {
            key = "<leader>fb";
            mode = "n";
            silent = true;
            action = "<cmd>Telescope buffers<cr>";
            desc = "Buffers";
          }
          {
            key = "<leader>fo";
            mode = "n";
            silent = true;
            action = "<cmd>Telescope oldfiles<cr>";
            desc = "Recent files";
          }
          {
            key = "<leader>fh";
            mode = "n";
            silent = true;
            action = "<cmd>Telescope help_tags<cr>";
            desc = "Help tags";
          }

          {
            key = "<leader>e";
            mode = "n";
            silent = true;
            action = "<cmd>NvimTreeToggle<cr>";
            desc = "File explorer";
          }

          {
            key = "<leader>db";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('dap').toggle_breakpoint()<cr>";
            desc = "Toggle breakpoint";
          }
          {
            key = "<leader>dc";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('dap').continue()<cr>";
            desc = "Continue";
          }
          {
            key = "<leader>di";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('dap').step_into()<cr>";
            desc = "Step into";
          }
          {
            key = "<leader>do";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('dap').step_over()<cr>";
            desc = "Step over";
          }
          {
            key = "<leader>dO";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('dap').step_out()<cr>";
            desc = "Step out";
          }
          {
            key = "<leader>du";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('dapui').toggle()<cr>";
            desc = "Toggle debug UI";
          }

          {
            key = "<leader>gs";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('gitsigns').stage_hunk()<cr>";
            desc = "Stage hunk";
          }
          {
            key = "<leader>gr";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('gitsigns').reset_hunk()<cr>";
            desc = "Reset hunk";
          }
          {
            key = "<leader>gp";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('gitsigns').preview_hunk()<cr>";
            desc = "Preview hunk";
          }
          {
            key = "<leader>gb";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('gitsigns').blame_line()<cr>";
            desc = "Blame line";
          }
          {
            key = "]c";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('gitsigns').next_hunk()<cr>";
            desc = "Next hunk";
          }
          {
            key = "[c";
            mode = "n";
            silent = true;
            action = "<cmd>lua require('gitsigns').prev_hunk()<cr>";
            desc = "Prev hunk";
          }

          {
            key = "<leader>tt";
            mode = "n";
            silent = true;
            action = "<cmd>ToggleTerm<cr>";
            desc = "Toggle terminal";
          }
          {
            key = "<leader>gg";
            mode = "n";
            silent = true;
            action = "<cmd>LazyGit<cr>";
            desc = "LazyGit";
          }

          {
            key = "<Tab>";
            mode = "n";
            silent = true;
            action = "<cmd>BufferLineCycleNext<cr>";
            desc = "Next buffer";
          }
          {
            key = "<S-Tab>";
            mode = "n";
            silent = true;
            action = "<cmd>BufferLineCyclePrev<cr>";
            desc = "Prev buffer";
          }
          {
            key = "q";
            mode = "n";
            silent = true;
            action = "<cmd>qa<cr>";
            desc = "Quit all";
          }
        ];
      };
    };
  };
}
