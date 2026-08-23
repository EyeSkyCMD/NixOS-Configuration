{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./programs.nix
    ./nvf.nix
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  home = {
    username = "eyesky";
    homeDirectory = "/home/eyesky";
    stateVersion = "25.05";

    pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    packages = with pkgs; [
      thunar
      pavucontrol
      mpv
      wl-clipboard
      fastfetch
      btop
      vesktop
      hyprshot
      unzip
      gimp
      ani-cli
      peaclock
      lavat
      gnumake
      cmatrix
      trash-cli
      cava
      chromium
      cpufetch
      krita
      wiremix
      obs-studio
      vscodium
      flatpak
      p7zip
      jq
      poppler
      fd
      ripgrep
      zoxide
      resvg
      imagemagick
      gpu-screen-recorder
      unar
      r2modman
      sgdboop
      protontricks
      aseprite
      heroic
      nixd
      toipe
      asciiquarium-transparent
      tldr
      lsd
      openrgb
      lazygit
      wine
      home-manager
    ];
  };
}
