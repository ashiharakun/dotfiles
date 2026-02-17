---
name: fix-issue
description: GitHubのissueを読んで修正し、PRを作成する
disable-model-invocation: true
argument-hint: <issue-number>
---

GitHub issue #$ARGUMENTS を解決してください。

## 手順

1. `gh issue view $ARGUMENTS` でissueの内容を確認
2. 適切なブランチ名でブランチを作成
3. 要件を理解し、必要なコード変更を特定
4. 修正を実装
5. 必要に応じてテストを追加・修正
6. コミットを作成（issueへの参照を含める）
7. PRを作成
8. 作業完了後はmainブランチに戻っておく

## 注意

- 実装前にissueの内容をよく読んで要件を把握すること
- 不明点があればユーザーに確認すること
- PRのタイトルは変更内容を簡潔に表すこと
