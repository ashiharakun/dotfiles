#!/bin/bash
# 標準入力からJSON形式のデータを読み込む
input=$(cat)

# 各種情報を取得
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
input_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // "0"')
output_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // "0"')
used=$(echo "$input" | jq -r '.context_window.used_percentage // "0"')
duration_ms=$(echo "$input" | jq -r '.cost.total_api_duration_ms // "0"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // "~"')

# レイテンシを秒に変換（小数点1桁）
latency=$(echo "scale=1; $duration_ms / 1000" | bc)

# カレントディレクトリを短く表示（ホームディレクトリを~に置換）
display_dir="${cwd/#$HOME/~}"

# Gitブランチ情報を取得（オプショナルロックをスキップ）
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    git_branch=" on  $branch"
  fi
fi

# ステータスライン表示
echo "${display_dir}${git_branch} | ${model} | ${input_tokens}/${output_tokens} tokens | Context: ${used}% used | ${latency}s"

