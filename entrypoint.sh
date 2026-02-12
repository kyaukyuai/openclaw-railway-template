#!/bin/bash
set -e

chown -R openclaw:openclaw /data

# Ensure persistent config directories exist
mkdir -p /data/.config

# Create symlinks for tool configs (gog, gh, etc.) to persist across restarts
OPENCLAW_HOME="/home/openclaw"

# gog CLI config
if [ -d "/data/.config/gogcli" ]; then
  mkdir -p "$OPENCLAW_HOME/.config"
  ln -sfn /data/.config/gogcli "$OPENCLAW_HOME/.config/gogcli"
fi

# gh CLI config (if stored)
if [ -d "/data/.config/gh" ]; then
  mkdir -p "$OPENCLAW_HOME/.config"
  ln -sfn /data/.config/gh "$OPENCLAW_HOME/.config/gh"
fi

exec gosu openclaw node src/server.js
