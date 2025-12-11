{ self, pkgs, userName, ... }:

{
  environment.systemPackages = [
    pkgs.vim
  ];

  nixpkgs.config.allowUnfree = true;

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
    primaryUser = userName;

    defaults.finder.AppleShowAllFiles = true;
  };

  nix.settings.experimental-features = "nix-command flakes";

  users.users.${userName} = {
    home = "/Users/${userName}/";
    uid = 501;
    shell = pkgs.zsh;
  };
}
