## README

macOS および NixOS で動作確認済み。

### 更新（flake の入力更新）
```bash
nix flake update
```

### macOS への適用（nix-darwin + Home Manager）
```bash
sudo darwin-rebuild switch --flake .#mm1p
```

### NixOS への適用（NixOS + Home Manager）
```bash
# paseri (aarch64-linux)
sudo nixos-rebuild switch --flake .#paseri

# basil (x86_64-linux, WSL2)
sudo nixos-rebuild switch --flake .#basil
```

### basil (WSL2) の初回セットアップ

NixOS-WSL はインストール直後のユーザーが `nixos` なので、そのまま `switch` するとデフォルトユーザーの切り替えが中途半端になり壊れる。`boot` でビルドして WSL を再起動すること。

```bash
# nixos ユーザーで dotfiles を clone してから
cd ~/dotfiles
nixos-rebuild boot --flake .#basil --sudo
```

```powershell
# Windows 側の PowerShell で再起動（root で一度起動してユーザーを作り直させる）
wsl -t NixOS
wsl -d NixOS --user root exit
wsl -t NixOS
wsl -d NixOS
```

`ashiharakun` で入れたら、dotfiles を `~/dotfiles` に移して再適用する（Home Manager のリンク先が `~/dotfiles` 固定のため）。

```bash
sudo mv /home/nixos/dotfiles ~/dotfiles
sudo chown -R ashiharakun:users ~/dotfiles
sudo nixos-rebuild switch --flake ~/dotfiles#basil
sudo rm -rf /home/nixos
```

- root で他ユーザー所有のリポジトリをビルドすると Git の所有者チェックで失敗する。`--sudo` を使うか、`path:/home/nixos/dotfiles#basil` のように `path:` を付ける
- 先に `switch` してしまい `nixos` ユーザーが消えた場合は、`wsl -d NixOS --user root` で入り、`nixos-rebuild boot --flake path:/home/nixos/dotfiles#basil` から再開する

### Home Manager のみ適用（非NixOSのLinuxでユーザー設定だけ反映）

macOS では nix-darwin 経由（上記）を使うこと。このコマンドは非NixOSの x86_64-linux 向け固定なので macOS では使わない。

```bash
home-manager switch --flake .#ashiharakun
```

### flake 全体のチェック
```bash
nix flake check
```

### フォーマット
```bash
nix fmt
```
