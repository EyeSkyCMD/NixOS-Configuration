{
  inputs,
  pkgs,
  system,
  ...
}: {
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        cat ~/.local/state/caelestia/sequences.txt
        fish_add_path ~/.spicetify
        fastfetch -l small
        echo fucking Nix.
      '';
      shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
        update = "sudo nixos-rebuild switch --upgrade(-all)";
        hm = "home-manager switch --flake /etc/nixos#eyesky";
        snedo = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old";
        cg = "sudo nix-store --gc";
        btw = "fastfetch";
        v = "nvim";
        c = "warp-cli connect";
        dis = "warp-cli disconnect";
        fishes = "asciiquarium -t";
        typing = "toipe";
        l = "lsd -l";
        la = "lsd -a";
      };
    };

    yazi = {
      enable = true;
      shellWrapperName = "yy";
      settings = {
        mgr = {
          sort_by = "mtime";
          sort_reverse = true;
        };
        opener.wine = [
          {
            run = ''wine "$1"'';
            desc = "Open with Wine";
            orphan = true;
          }
        ];
        open.rules = [
          {
            url = "*.exe";
            use = "wine";
          }
          {
            url = "*";
            use = "open";
          }
        ];
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
      theme = {
        name = "marketplace";
        src = pkgs.fetchFromGitHub {
          owner = "spicetify";
          repo = "marketplace";
          rev = "main";
          hash = "sha256-mOmIi+AF78zHt55WkU6jWm7PndohxcQkVK6FhU86kDw";
        };
        injectCss = true;
        replaceColors = true;
        homeConfig = true;
      };
      enabledCustomApps = with spicePkgs; [apps.marketplace];
      enabledExtensions = with spicePkgs; [
        extensions.adblockify
        extensions.hidePodcasts
        extensions.shuffle
        extensions.sideHide
      ];
    };

    starship = {
      enable = true;
      settings = {
        scan_timeout = 300;
      };
      presets = ["nerd-font-symbols"];
    };

    caelestia = {
      enable = true;
      systemd.enable = true;
      cli.enable = true;
    };

    git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
        user = {
          name = "EyeSkyCMD";
          email = "izxiy314@gmail.com";
        };
      };
    };

    foot = {
      enable = true;
      settings = {
        main = {
          shell = "${pkgs.tmux}/bin/tmux";
          font = "CaskaydiaCove Nerd Font Mono:size=11";
        };
        tweak = {
          font-monospace-warn = "no";
        };
        colors-dark = {
          alpha = "0.8";
          background = "1e1e2e";
          foreground = "dcdccc";
        };
      };
    };
    tmux = {
      enable = true;
      extraConfig = ''
        set -g mouse on
        set -g status-style bg=default
        set -g window-style bg=default
        set -g window-active-style bg=default
        set -g pane-border-style bg=default
        set -g pane-active-border-style bg=default
        set -g default-terminal "tmux-256color"
        set -as terminal-overrides ",*:Tc"
      '';
    };
  };
}
