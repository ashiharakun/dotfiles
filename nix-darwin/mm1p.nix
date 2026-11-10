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
    ];
    brews = [ ];
    casks = [
      "discord"
      "firefox"
      "ghostty"
      "obsidian"
      "tinycast"
      "1password-cli"
      "zed"
      "vivaldi"
      "1password"
      "karabiner-elements"
      "lm-studio"
      "libreoffice"
      "netnewswire"
      "proton-pass"
      "scroll-reverser"
      "steam"
      "tailscale-app"
    ];
  };
}
