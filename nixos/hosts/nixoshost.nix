{ ... }:

{
  imports = [
    ../default.nix
    ./nixoshost-hardware.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "nixoshost";

  # ブートローダー（UEFI 環境の場合）
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.11";
}
