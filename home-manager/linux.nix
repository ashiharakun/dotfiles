{ pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  # fcitx5 キーバインド（左Alt: IME オフ、右Alt: IME オン）
  xdg.configFile."fcitx5/config".text = ''
    [Hotkey]
    TriggerKeys=
    ActivateKeys=Alt_R
    DeactivateKeys=Alt_L
  '';

  programs.firefox = {
    enable = true;
    # Alt キーがメニューバーに吸われないようにする
    profiles.default.settings = {
      "ui.key.menuAccessKeyFocuses" = false;
    };
  };
}
