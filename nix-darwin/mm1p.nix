{ ... }:

{
  imports = [
    ./default.nix
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # 端末固有の追加/上書きはここに集約
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    taps = [
      "abue-ammar/tinycast"
    ];
    brews = [ ];
    casks = [
      "discord"
      "firefox"
      "ghostty"
      "obsidian"
      "abue-ammar/tinycast/tinycast"
      "1password-cli"
      "zed"
      "moonlight"
      "vivaldi"
      "pearcleaner"
      "1password"
      "claude"
      "karabiner-elements"
      "lm-studio"
      "libreoffice"
      "netnewswire"
      "nextcloud"
      "proton-pass"
      "scroll-reverser"
      "steam"
      "tailscale-app"
      "utm"
      "hhkb-studio"
    ];
  };
}
