#!/usr/bin/env bash
# push_blog.sh - 推送博客到 GitHub
# token 从 $GITHUB_TOKEN 环境变量读，命令行 ps 看不到
set -e

REPO_DIR="C:/Users/Administrator/xiaohuoshuan123.github.io"
REPO_URL_BASE="https://github.com/xiaohuoshuan123/xiaohuoshuan123.github.io.git"

if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ GITHUB_TOKEN 未设置"
    echo "   请先: export GITHUB_TOKEN=\$(cat /c/Users/Administrator/github_token.txt | tail -1)"
    exit 1
fi

# 验证 token 格式（应 ghp_ 开头 36 字符）
if [[ ! "$GITHUB_TOKEN" =~ ^ghp_[A-Za-z0-9]{36}$ ]]; then
    echo "⚠️  Token 格式异常: ${GITHUB_TOKEN:0:4}...${GITHUB_TOKEN: -4} (len=${#GITHUB_TOKEN})"
    read -p "继续吗? (y/N) " ans
    [[ "$ans" == "y" ]] || exit 1
fi

# 临时 askpass 脚本（不写到磁盘，用 here-doc + chmod）
ASKPASS=$(mktemp /tmp/hermes-askpass-XXXXXX.sh)
cat > "$ASKPASS" <<EOF
#!/bin/sh
echo "\$GITHUB_TOKEN"
EOF
chmod +x "$ASKPASS"

cd "$REPO_DIR" || exit 1

# 配置 git 使用 askpass（避免命令行暴露 token）
export GIT_ASKPASS="$ASKPASS"
export GIT_TERMINAL_PROMPT=0

# 第一次 commit（如果是空的）
if ! git rev-parse HEAD >/dev/null 2>&1; then
    echo "--- 首次提交 ---"
    git add -A
    git commit -m "feat: 初始化博客

- _config.yml: Jekyll + minima 主题
- index.md: 首页含答题领礼品入口按钮
- README.md: 站点说明"
fi

# 配置 remote（如果还没）
if ! git remote get-url origin >/dev/null 2>&1; then
    git remote add origin "$REPO_URL_BASE"
fi

# 推送到 main 分支
echo "--- 推送到 GitHub ---"
git push -u origin main --force

# 清理
rm -f "$ASKPASS"
echo "✅ 推送完成！"
echo "1-2 分钟后访问 https://xiaohuoshuan123.github.io"
