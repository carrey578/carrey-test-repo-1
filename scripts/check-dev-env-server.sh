#!/bin/bash
# check-dev-env-server.sh
# 服务器端开发环境检查脚本

echo "=== 服务器开发环境检查 ==="
echo ""

# 1. 检查当前仓路径
echo "[1] 检查仓库路径..." 
if [ -d "/root/workspace/repos/carrey-test-repo-1" ]; then
    echo "  ✓ 仓库路径存在: /root/workspace/repos/carrey-test-repo-1"
else
    echo "  ✗ 仓库路径不存在"
fi

# 2. 检查分支
echo "[2] 检查 Git 分支..."
cd /root/workspace/repos/carrey-test-repo-1 2>/dev/null
branch=$(git branch --show-current 2>/dev/null)
if [ "$branch" = "chore/cursor-bootstrap" ]; then
    echo "  ✓ 当前分支: $branch"
elif [ -n "$branch" ]; then
    echo "  ⚠ 当前分支: $branch (建议切换到 chore/cursor-bootstrap)"
else
    echo "  ✗ 非 Git 仓库"
fi

# 3. 检查共享目录
echo "[3] 检查共享目录..."
if [ -d "docs/collab/chatgpt-lingxi" ]; then
    echo "  ✓ 共享目录存在"
else
    echo "  ✗ 共享目录不存在"
fi

# 4. 检查 OpenClaw 工作目录
echo "[4] 检查 OpenClaw 工作目录..."
if [ -d "/root/.openclaw" ]; then
    echo "  ✓ OpenClaw 目录存在"
else
    echo "  ✗ OpenClaw 目录不存在"
fi

# 5. 检查 OpenClaw workspace
echo "[5] 检查 OpenClaw workspace..."
if [ -d "/root/.openclaw/workspace" ]; then
    echo "  ✓ workspace 目录存在"
else
    echo "  ✗ workspace 目录不存在"
fi

# 6. 检查 OpenClaw 进程
echo "[6] 检查 OpenClaw 进程..."
if ps aux | grep -i "openclaw-gateway" | grep -v grep > /dev/null; then
    echo "  ✓ OpenClaw Gateway 运行中"
else
    echo "  ⚠ OpenClaw Gateway 未运行"
fi

echo ""
echo "=== 检查完成 ==="
