{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [inputs.millennium.overlays.default];

  imports = [
    ./hardware-configuration.nix
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://cache.nixos.org" "https://nix-community.cachix.org"];
    trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    max-jobs = "auto";
    cores = 0;
  };

  documentation.enable = false;
  nixpkgs.config.allowUnfree = true;
  boot = {
    loader.grub = {
      enable = true;
      efiSupport = true;
      devices = ["nodev"];
      configurationLimit = 10;
      extraEntries = ''
        menuentry "Gentoo" {
          insmod part_gpt
          insmod fat
          insmod chain
          search --fs-uuid --set=root DDE7-49D0
          chainloader /EFI/gentoo/grubx64.efi
         }
      '';
    };
    kernelParams = ["nvidia_drm.modeset=1" "nvidia_drm.fbdev=1" "nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nftables.enable = true;
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
        user = "greeter";
      };
    };
    xserver.videoDrivers = ["nvidia"];

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    upower.enable = true;
    flatpak.enable = true;
    cloudflare-warp.enable = true;
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth.enable = true;
  };

  programs = {
    gamemode.enable = true;
    gamescope.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      package = pkgs.millennium-steam;
    };

    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    fish.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

  security = {
    rtkit.enable = true;
    wrappers.gsr-kms-server = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+ep";
      source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
    };
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  fonts.packages = with pkgs; [
    material-symbols
    nerd-fonts.caskaydia-cove
    rubik
    nerd-fonts.fira-code
  ];
  # Define a user account. Set a password ‘passwd’.
  users.users.eyesky = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video" "input"]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = [
      pkgs.tree
    ];
  };

  users.extraGroups.vboxusers.members = ["eyesky"];

  environment.systemPackages = with pkgs; [
    wget
    webp-pixbuf-loader
    libheif
    pulseaudio
    cloudflare-warp
  ];
  system.stateVersion = "26.05";
}
