# CLAUDE.md

このファイルは Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイドです。

## リポジトリ概要

macOS (aarch64-darwin) 向けの dotfiles リポジトリ。Nix Flakes + nix-darwin + Home Manager で構成管理を行う。

## よく使うコマンド

```bash
# macOS全体への適用（nix-darwin + Home Manager）
sudo darwin-rebuild switch --flake .#mm1p

# Home Managerのみ適用
home-manager switch --flake .#ashiharakun

# flake入力の更新
nix flake update

# flake全体のチェック
nix flake check

# Nixフォーマッター（nixpkgs-fmt）
nix fmt
```

## アーキテクチャ

### Nix Flake 構成

- `flake.nix` — エントリポイント。flake-parts を使用し、darwinConfigurations と homeConfigurations を定義
- `nix-darwin/default.nix` — macOS 共通のシステム設定（Nix 実験機能、Touch ID sudo 等）
- `nix-darwin/mm1p.nix` — ホスト固有設定（Homebrew casks など）。`default.nix` を import
- `home-manager/default.nix` — ユーザー環境の共通設定（パッケージ、シェル、シンボリックリンク）
- `home-manager/hosts/ashiharakun.nix` — ユーザー固有の設定オーバーライド用。`../default.nix` を import

### dotfiles の配置方式

`home-manager/default.nix` で `mkOutOfStoreSymlink` を使い、リポジトリ内の設定ファイルを `~/.config/` や `~/.claude/` にシンボリックリンクする。ファイルを追加・移動した場合はここのマッピングも更新すること。

### 管理対象アプリケーション

| ディレクトリ | 対象 | リンク先 |
|---|---|---|
| `nvim/` | Neovim (lazy.nvim) | `~/.config/nvim` |
| `sheldon/` | sheldon (zsh プラグイン) | `~/.config/sheldon` |
| `yazi/` | yazi (ファイラー) | `~/.config/yazi` |
| `zeno/` | zeno (zsh 補完) | `~/.config/zeno` |
| `zsh/` | zsh (zshrc, zshenv) | Home Manager の initContent から source |
| `wezterm/` | WezTerm | （手動リンクまたは別途設定） |
| `claude/` | Claude Code | `~/.claude/` |

## Nix ファイル編集時の注意

- フォーマッターは `nixpkgs-fmt`（`nix fmt` で実行）
- パッケージ追加は `home-manager/default.nix` の `home.packages` へ
- Homebrew cask 追加は `nix-darwin/mm1p.nix` の `homebrew.casks` へ
- 新しいホスト対応は `nix-darwin/` と `home-manager/hosts/` にそれぞれファイルを追加
