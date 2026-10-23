{ ... }:

{
  imports = [
    ./ashiharakun.nix
  ];

  # Windows 側の OpenSSH を使い、1Password の SSH エージェント経由で鍵を利用する。
  programs.git.settings.core.sshCommand = "/mnt/c/Windows/System32/OpenSSH/ssh.exe";
}
