{
  config,
  pkgs-unstable,
  ...
}:
let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home.packages = [
    pkgs-unstable.claude-code
  ];

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
}
