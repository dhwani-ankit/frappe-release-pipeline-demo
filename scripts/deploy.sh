#!/bin/bash
# Deployment script for Frappe bench
# This script is called by GitHub Actions via SSH

set -e

echo "🚀 Starting deployment..."
echo "📍 Current directory: $(pwd)"
echo "⏰ Deployment started at: $(date)"

# Navigate to bench directory (if not already there)
if [ -n "$BENCH_DIRECTORY" ]; then
    cd "$BENCH_DIRECTORY"
    echo "📂 Changed to bench directory: $BENCH_DIRECTORY"
fi

# Pull latest changes
echo "📥 Pulling latest app changes..."
bench update --pull --build

# Run migrations
echo "🔄 Running migrations..."
bench migrate

# Restart bench
echo "♻️ Restarting bench..."
bench restart

echo "✅ Deployment completed successfully!"
echo "⏰ Deployment finished at: $(date)"

