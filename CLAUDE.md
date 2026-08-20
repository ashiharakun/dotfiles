## リポジトリ概要

macOS (aarch64-darwin) および NixOS (aarch64-linux, x86_64-linux) 向けの dotfiles リポジトリ。Nix Flakes + nix-darwin + Home Manager + NixOS で構成管理を行う。

## アーキテクチャ

### Nix Flake 構成

- `flake.nix` — エントリポイント。flake-parts を使用し、darwinConfigurations・nixosConfigurations・homeConfigurations を定義
- `nix-darwin/default.nix` — macOS 共通のシステム設定（Nix 実験機能、Touch ID sudo 等）
- `nix-darwin/mm1p.nix` — macOS ホスト固有設定（Homebrew casks など）。`default.nix` を import
- `nixos/default.nix` — NixOS 共通設定（ユーザー、zsh、日本語入力 fcitx5 等）
- `nixos/hosts/paseri/` — NixOS ホスト `paseri`（aarch64-linux）固有設定（`configuration.nix`, `hardware-configuration.nix`）
- `nixos/hosts/basil/` — NixOS ホスト `basil`（x86_64-linux, WSL2）固有設定（`configuration.nix`, `hardware-configuration.nix`）
- `nixos/hosts/sage/` — NixOS ホスト `sage`（x86_64-linux, NVIDIA RTX 4060 Ti 搭載の物理マシン向け）固有設定（`configuration.nix`, `hardware-configuration.nix`）
- `nixos/hosts/mint/` — NixOS ホスト `mint`（x86_64-linux, ZFS + Docker で各種サービスを動かすサーバー向け）固有設定（`configuration.nix`, `hardware-configuration.nix`）
- `home-manager/default.nix` — ユーザー環境の共通設定（パッケージ、シェル、シンボリックリンク）。全ホスト共通、GUI の有無を問わない
- `home-manager/linux-gui.nix` — Linux で GUI がある端末専用の Home Manager 設定（Hyprland, fcitx5 キーバインド, Firefox 等）。`default.nix` に加えて GUI があるホストの設定ファイルからのみ import する
- `home-manager/linux-gui-standalone.nix` — NixOS ではない Linux（Pop!_OS など）かつサーバーではないホスト専用の GUI アプリ（Ghostty 等）。ディスプレイマネージャーや polkit 統合など NixOS のシステムモジュールに依存するものは書かないこと
- `home-manager/hosts/ashiharakun.nix` — GUI のないホスト（`basil` など）向け。`../default.nix` のみを import
- `home-manager/hosts/paseri.nix`, `home-manager/hosts/sage.nix` — GUI があるホスト向け。`../default.nix` と `../linux-gui.nix` を import
- `home-manager/hosts/pop-os.nix` — NixOS ではない Linux（Pop!_OS）向け。`../default.nix` と `../linux-gui-standalone.nix` を import。`home-manager switch --flake .#pop-os` で適用
- `home-manager/hosts/mint.nix` — サーバー用途の `mint` 向け。`../default.nix` のみを import

### dotfiles の配置方式

`home-manager/default.nix` で `mkOutOfStoreSymlink` を使い、リポジトリ内の設定ファイルを `~/.config/` や `~/.claude/` にシンボリックリンクする。ファイルを追加・移動した場合はここのマッピングも更新すること。

### 管理対象アプリケーション

| ディレクトリ | 対象 | リンク先 | 備考 |
|---|---|---|---|
| `nvim/` | Neovim (lazy.nvim) | `~/.config/nvim` | |
| `sheldon/` | sheldon (zsh プラグイン) | `~/.config/sheldon` | |
| `yazi/` | yazi (ファイラー) | `~/.config/yazi` | |
| `zeno/` | zeno (zsh 補完) | `~/.config/zeno` | |
| `ghostty/` | Ghostty (ターミナル) | `~/.config/ghostty` | |
| `hypr/` | Hyprland (ウィンドウマネージャー) | `~/.config/hypr` | Linux のみ |
| `zsh/` | zsh (zshrc, zshenv) | Home Manager の initContent から source | |
| `claude/` | Claude Code | `~/.claude/` | CLAUDE.md, settings.json, statusline.sh, skills/ |

## Nix ファイル編集時の注意

- フォーマッターは `nixfmt`（`nix fmt` で実行、`treefmt-nix` 経由）
- パッケージ追加は `home-manager/default.nix` の `home.packages` へ
- Homebrew cask 追加は `nix-darwin/mm1p.nix` の `homebrew.casks` へ
- NixOS ホスト固有設定は `nixos/hosts/<hostname>/configuration.nix` へ
- 新しいホスト対応は `nix-darwin/` または `nixos/hosts/` と `home-manager/hosts/` にそれぞれファイルを追加
- GUI がある Linux ホスト専用の Home Manager 設定は `home-manager/linux-gui.nix` に追記し、GUI があるホストの `home-manager/hosts/<hostname>.nix` から import する（GUI のないホストからは import しないこと）
