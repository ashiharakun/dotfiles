{ userName, ... }:

{
  imports = [
    ../../default.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = userName;

  networking.hostName = "basil";

  system.stateVersion = "25.11";
}
