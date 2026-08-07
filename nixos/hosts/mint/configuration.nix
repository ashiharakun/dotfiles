{ pkgs, ... }:

{
  imports = [
    ../../default.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "mint";
  # ZFS が pool を識別するために必要な一意な ID(8桁 hex)
  networking.hostId = "d5f05628";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "tank" ];
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

  # tank 配下の各 dataset は mountpoint=legacy にした上でここでマウント管理する
  # nofail: tank プールが未作成でも起動を継続できるようにする(プール作成後は自動的にマウントされる)
  fileSystems."/hdd/misskey" = {
    device = "tank/misskey";
    fsType = "zfs";
    options = [ "nofail" ];
  };
  fileSystems."/hdd/nextcloud" = {
    device = "tank/nextcloud";
    fsType = "zfs";
    options = [ "nofail" ];
  };
  fileSystems."/hdd/karakeep" = {
    device = "tank/karakeep";
    fsType = "zfs";
    options = [ "nofail" ];
  };
  fileSystems."/hdd/freshrss" = {
    device = "tank/freshrss";
    fsType = "zfs";
    options = [ "nofail" ];
  };
  fileSystems."/hdd/beszel" = {
    device = "tank/beszel";
    fsType = "zfs";
    options = [ "nofail" ];
  };

  time.timeZone = "Asia/Tokyo";

  virtualisation.docker.enable = true;

  services.tailscale.enable = true;

  services.adguardhome.enable = true; # 管理画面はデフォルトの3000番のまま。karakeep側を81番にずらして競合回避

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  system.stateVersion = "26.05";
}
