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

# 7. 检查内存使用
echo "[7] 检查内存使用..."
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_total=$(free -m | awk '/Mem:/ {print $2}')
if [ -n "$mem_used" ] && [ -n "$mem_total" ]; then
    mem_percent=$((mem_used * 100 / mem_total))
    echo "  ✓ 内存使用: ${mem_used}MB / ${mem_total}MB (${mem_percent}%)"
fi

# 8. 检查磁盘使用
echo "[8] 检查磁盘使用..."
disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_percent=$(df -h / | awk 'NR==2 {print $5}')
if [ -n "$disk_used" ]; then
    echo "  ✓ 磁盘使用: ${disk_used} / ${disk_total} (${disk_percent})"
fi

# 9. 检查 Node 版本
echo "[9] 检查 Node 版本..."
if command -v node &> /dev/null; then
    node_version=$(node --version)
    echo "  ✓ Node: $node_version"
else
    echo "  ✗ Node 未安装"
fi

# 10. 检查 Git 状态
echo "[10] 检查 Git 状态..."
cd /root/workspace/repos/carrey-test-repo-1 2>/dev/null
if git rev-parse --git-dir > /dev/null 2>&1; then
    status=$(git status --porcelain)
    if [ -z "$status" ]; then
        echo "  ✓ 工作区干净"
    else
        echo "  ⚠ 有未提交的更改"
    fi
    remote=$(git remote get-url origin 2>/dev/null)
    echo "  ✓ 远程: $remote"
fi

echo ""
echo "=== 检查完成 ==="
