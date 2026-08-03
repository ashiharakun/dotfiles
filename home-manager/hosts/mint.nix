{ lib, ... }:

{
  imports = [
    ../default.nix
  ];

  # サーバー用途のため GUI アプリ(Firefox)は無効化
  programs.firefox.enable = lib.mkForce false;
}
