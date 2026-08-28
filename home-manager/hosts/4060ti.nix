{ config, ... }:

{
  imports = [
    ../default.nix
    ../linux-gui-standalone.nix
    ../claude.nix
  ];

  # Bitwarden デスクトップアプリの SSH エージェントを使う（.deb / AppImage 版）。
  # Flatpak 版なら
  # "${config.home.homeDirectory}/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock"
  home.sessionVariables.SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
}
