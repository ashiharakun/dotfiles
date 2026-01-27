{ config, pkgs, lib, userName, ... }:
let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home = {
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      git
      eza
      fish
      gh
      ghq
      lazygit
      yazi
      mise
      starship
      deno
      fzf
      sheldon
      yt-dlp
      codex
      claude-code
    ];
  };

  programs = {
    home-manager.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
    zsh = {
      enable = true;
      initContent = lib.mkMerge [
        (lib.mkBefore ''
          # Prefer Nix paths over Homebrew
          path=("/run/current-system/sw/bin" "/etc/profiles/per-user/${userName}/bin" "$HOME/.nix-profile/bin" $path)
        '')
        ''
          source "${dotfilesDir}/zsh/zshrc"
        ''
      ];
      envExtra = ''
        source "${dotfilesDir}/zsh/zshenv"
      '';
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  xdg = {
    configFile = {
      "nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";
        force = true; # ensure ~/.config/nvim is a symlink to repo
      };
      "sheldon" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/sheldon";
        force = true;
      };
      "yazi" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/yazi";
        force = true;
      };
      "zeno" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/zeno";
        force = true;
      };
    };
  };
}
