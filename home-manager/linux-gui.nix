{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages =
    with pkgs;
    [
      ghostty
      obsidian
      zed-editor
      nextcloud-client
    ]
    # discord は aarch64-linux 未対応
    ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [ discord ];

  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";
    force = true;
  };

  # fcitx5 キーバインド（左Alt: IME オフ、右Alt: IME オン）
  xdg.configFile."fcitx5/config" = {
    force = true;
    text = ''
      [Hotkey]
      TriggerKeys=
      ActivateKeys=Alt_R
      DeactivateKeys=Alt_L
    '';
  };

  # KDE Plasma セッションでは KWin が X-KDE-Wayland-VirtualKeyboard=true を見て
  # fcitx5 を直接起動する一方、ksmserver の通常オートスタート処理も同じ
  # /etc/xdg/autostart/org.fcitx.Fcitx5.desktop を起動してしまい、2つ目の
  # プロセスが D-Bus 名の取得に失敗して IME のトグルキーが不安定になる問題への対処。
  # NotShowIn=KDE を追加して ksmserver 側の起動を抑止する（KWin 側の起動は影響を受けない）。
  xdg.configFile."autostart/org.fcitx.Fcitx5.desktop" = {
    force = true;
    text = ''
      [Desktop Entry]
      Name=Fcitx 5
      GenericName=Input Method
      Comment=Start Input Method
      Exec=fcitx5
      Icon=fcitx
      Terminal=false
      Type=Application
      Categories=System;Utility;
      StartupNotify=false
      NotShowIn=KDE;
      X-GNOME-AutoRestart=false
      X-GNOME-Autostart-Notify=false
      X-KDE-autostart-after=panel
      X-KDE-StartupNotify=false
      X-KDE-Wayland-VirtualKeyboard=true
      X-KDE-Wayland-Interfaces=org_kde_plasma_window_management
    '';
  };

  programs.firefox = {
    enable = true;
    # Alt キーがメニューバーに吸われないようにする
    profiles.default.settings = {
      "ui.key.menuAccessKeyFocuses" = false;
    };
  };
}
