{ config, pkgs, pkgs-unstable, lib, userName, ... }:
let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  imports = [ ./linux.nix ];
  home = {
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      git
      eza
      gh
      ghq
      lazygit
      yazi
      mise
      starship
      deno
      fzf
      sheldon
      zoxide
      yt-dlp
      codex
      pkgs-unstable.claude-code
      ffmpeg
      plemoljp-nf
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
        (lib.mkBefore (lib.optionalString pkgs.stdenv.isDarwin ''
          # Prefer Nix paths over Homebrew (macOS only)
          path=("/run/current-system/sw/bin" "/etc/profiles/per-user/${userName}/bin" "$HOME/.nix-profile/bin" $path)
        ''))
        ''
          source "${dotfilesDir}/zsh/zshrc"
        ''
      ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.file = {
    ".claude/CLAUDE.md" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/claude/CLAUDE.md";
    };
    ".claude/settings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/claude/settings.json";
    };
    ".claude/statusline.sh" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/claude/statusline.sh";
    };
    ".claude/skills" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/claude/skills";
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
      "ghostty" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/ghostty";
        force = true;
      };
    };
  };
}
