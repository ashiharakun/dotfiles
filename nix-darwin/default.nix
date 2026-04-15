{ self, pkgs, userName, ... }:

{
  environment.systemPackages = [
    pkgs.vim
  ];

  nixpkgs.config.allowUnfree = true;

  # direnv のビルド時 fish テストが macOS セキュリティ機構に kill されるため無効化
  nixpkgs.overlays = [
    (final: prev: {
      direnv = prev.direnv.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
    primaryUser = userName;

    defaults.finder.AppleShowAllFiles = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;

  nix.settings.experimental-features = "nix-command flakes";

  users.users.${userName} = {
    home = "/Users/${userName}";
    uid = 501;
    shell = pkgs.zsh;
  };
}
