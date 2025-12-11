## 使い方メモ

### 更新（flakeの入力更新）
```bash
nix flake update
```

### macOSへの適用（nix-darwin + Home Manager）
```bash
sudo darwin-rebuild switch --flake .mm1p#
```

### Home Managerのみ適用（Linux/NixOSやmacOSでユーザ設定だけ反映）
```bash
home-manager switch --flake .#ashiahrakun
```

### flake全体のチェック
```bash
nix flake check
```
