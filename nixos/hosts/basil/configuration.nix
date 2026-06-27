{ userName, ... }:

{
  imports = [
    ../../default.nix
    ./hardware-configuration.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = userName;

  networking.hostName = "basil";

  time.timeZone = "Asia/Tokyo";

  # WSL では入力メソッドは不要
  i18n.inputMethod.enable = false;

  system.stateVersion = "25.11";
}
