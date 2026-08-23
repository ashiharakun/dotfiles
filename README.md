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

# sage (x86_64-linux, NVIDIA RTX 4060 Ti)
sudo nixos-rebuild switch --flake .#sage

# mint (x86_64-linux, サーバー)
sudo nixos-rebuild switch --flake .#mint
```

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
