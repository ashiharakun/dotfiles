# このファイルは nixos-generate-config で生成されたものに差し替えること
# nixos インストール後: cp /etc/nixos/hardware-configuration.nix ./nixos/hosts/nixoshost-hardware.nix
{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # 実機の hardware-configuration.nix に差し替えてください
}
