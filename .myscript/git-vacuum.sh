#!/bin/bash
# git vacuum: 指定ブランチへ切り替え、マージ済みブランチと
# それに紐づく worktree をまとめて削除する。
#
# usage: git vacuum [base-branch]   (省略時は現在のブランチ)

set -u

base="${1:-}"

git fetch --prune || exit 1

if [ -n "$base" ]; then
    git checkout "$base" || exit 1
fi
base="$(git rev-parse --abbrev-ref HEAD)"

# 保護するブランチ (現在のブランチ + 主要ブランチ)
is_protected() {
    case "$1" in
        "$base"|develop|main|master) return 0 ;;
        *) return 1 ;;
    esac
}

# ブランチ名 -> worktree のパス (worktree 未使用なら空)
worktree_path_of() {
    git worktree list --porcelain | awk -v branch="refs/heads/$1" '
        /^worktree /  { path = substr($0, 10) }
        /^branch /    { if (substr($0, 8) == branch) { print path; exit } }
    '
}

merged="$(git branch --merged | sed 's/^[*+] *//; s/^ *//')"

[ -z "$merged" ] && exit 0

echo "$merged" | while IFS= read -r branch; do
    [ -z "$branch" ] && continue
    is_protected "$branch" && continue

    wt="$(worktree_path_of "$branch")"
    if [ -n "$wt" ]; then
        echo "removing worktree: $wt ($branch)"
        if ! git worktree remove "$wt"; then
            echo "  skip: worktree に未コミットの変更があります -> $wt" >&2
            continue
        fi
    fi

    git branch -d "$branch"
done

git worktree prune
