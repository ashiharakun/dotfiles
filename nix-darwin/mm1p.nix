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
    brews = [ ];
    casks = [
      "discord"
      "firefox"
      "ghostty"
      "wezterm@nightly"
      "obsidian"
      "pearcleaner"
      "pleck-jp"
      "raycast"
      "vivaldi"
    ];
  };
}
