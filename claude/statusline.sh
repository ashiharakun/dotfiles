#!/bin/bash
# 標準入力からJSON形式のデータを読み込む
input=$(cat)

# 各種情報を取得
model=$(echo "$input" | jq -r '.model.display_name // "Claude"' | sed 's/^Claude //')
used=$(echo "$input" | jq -r '.context_window.used_percentage // "0"')
duration_ms=$(echo "$input" | jq -r '.cost.total_api_duration_ms // "0"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // "~"')
rate_5h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
rate_7d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# レイテンシを秒に変換（小数点1桁）
latency=$(echo "scale=1; $duration_ms / 1000" | bc)

# カレントディレクトリを短く表示（ホームディレクトリを~に置換）
display_dir="${cwd/#$HOME/~}"

# Gitブランチ情報を取得（オプショナルロックをスキップ）
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    git_branch="  $branch"
  fi
fi

# レート制限情報を組み立て
rate_info=""
[ -n "$rate_5h" ] && rate_info="5h: $(printf '%.0f' "$rate_5h")%"
[ -n "$rate_7d" ] && rate_info="${rate_info:+$rate_info }7d: $(printf '%.0f' "$rate_7d")%"

# ステータスライン表示
if [ -n "$rate_info" ]; then
  echo "${display_dir}${git_branch} | ${model} | ctx:${used}% | ${latency}s | ${rate_info}"
else
  echo "${display_dir}${git_branch} | ${model} | ctx:${used}% | ${latency}s"
fi

