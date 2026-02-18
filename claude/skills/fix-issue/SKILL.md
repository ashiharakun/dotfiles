---
name: fix-issue
description: GitHubのissueを読んで修正し、PRを作成する
disable-model-invocation: true
argument-hint: <issue-number>
---

GitHub issue #$ARGUMENTS を解決してください。

## 手順

1. `gh issue view $ARGUMENTS` でissueの内容を確認
2. 自分がmainブランチにいることを確認し、また最新の状態であることを確認する（最新でない場合pullしておく）
3. 適切なブランチ名でブランチを作成
4. 要件を理解し、必要なコード変更を特定
5. 修正を実装
6. 必要に応じてテストを追加・修正
7. コミットを作成（issueへの参照を含める）
8. PRを作成
9. 作業完了後はmainブランチに戻っておく

## 注意

- 実装前にissueの内容をよく読んで要件を把握すること
- 不明点があればユーザーに確認すること
- PRのタイトルは変更内容を簡潔に表すこと
