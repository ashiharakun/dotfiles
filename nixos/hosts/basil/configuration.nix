{ pkgs, userName, ... }:

{
  imports = [
    ../../default.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "basil";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Tokyo";

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # NVIDIA RTX 4060 Ti（シングル GPU、内蔵グラフィックなし）
  hardware.nvidia = {
    modesetting.enable = true;
    # オープンソースカーネルモジュール（Turing 以降推奨）
    open = true;
    nvidiaSettings = true;
    package = pkgs.linuxPackages.nvidiaPackages.stable;
  };
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # KDE Plasma 6
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Wayland / Hyprland
  programs.hyprland = {
    enable = true;
    # NVIDIA 向け: DRM カーネルモードセッティングを有効化
    withUWSM = true;
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # 1Password（GUI の polkit 統合に専用モジュールが必要）
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ userName ];
  };

  environment.systemPackages = with pkgs; [
    ghostty
    obsidian
    vivaldi
    # Hyprland 関連
    waybar
    wofi
    dunst
    wl-clipboard
    grim
    slurp
    networkmanagerapplet
    xdg-utils
  ];

  system.stateVersion = "25.11";
}
