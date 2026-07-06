{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  userName,
  ...
}:
let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  imports = [
    ./linux.nix
    ./yazi.nix
    ./direnv.nix
  ];
  home = {
    stateVersion = "26.05";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      git
      eza
      jq
      gh
      ghq
      lazygit
      mise
      starship
      deno
      fzf
      sheldon
      zoxide
      yt-dlp
      pkgs-unstable.claude-code
      pkgs-unstable.herdr
      ffmpeg
      plemoljp-nf
      rtk
      lua-language-server
      nil
      bash-language-server
    ];
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      settings = {
        user = {
          name = "ashiharakun";
          email = "github.reconcile469@passmail.net";
        };
        url."git@github.com:".insteadOf = "https://github.com/";
      };
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      sideloadInitLua = true;
    };
    zsh = {
      enable = true;
      initContent = lib.mkMerge [
        (lib.mkBefore (
          lib.optionalString pkgs.stdenv.isDarwin ''
            # Prefer Nix paths over Homebrew (macOS only)
            path=("/run/current-system/sw/bin" "/etc/profiles/per-user/${userName}/bin" "$HOME/.nix-profile/bin" $path)
          ''
        ))
        ''
          source "${dotfilesDir}/zsh/zshrc"
        ''
      ];
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
        force = true;
        recursive = true;
      };
      "sheldon" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/sheldon";
        force = true;
        recursive = true;
      };
      "zeno" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/zeno";
        force = true;
        recursive = true;
      };
      "ghostty" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/ghostty";
        force = true;
        recursive = true;
      };
    };
  };
}
