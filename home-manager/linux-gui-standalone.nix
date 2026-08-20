{ pkgs, ... }:

{
  # NixOS ではない Linux (例: Pop!_OS) かつサーバーではないホスト専用の GUI アプリ。
  # ディスプレイマネージャーや polkit 統合など NixOS のシステムモジュールに
  # 依存するものはここに書かず、単体で動くアプリのみを置くこと。
  home.packages = with pkgs; [ ];
}
