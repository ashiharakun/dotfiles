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
sudo nixos-rebuild switch --flake .#paseri
```

### Home Manager のみ適用（Linux/NixOS や macOS でユーザー設定だけ反映）
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
