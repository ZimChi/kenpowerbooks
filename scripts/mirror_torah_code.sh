#!/usr/bin/env bash
set -euo pipefail
BASE_URL="https://www.kenpowerbooks.com/the-torah-code"
TARGET_DIR="$(cd "$(dirname "$0")/.." && pwd)/the-torah-code"

echo "Mirroring $BASE_URL into $TARGET_DIR"
cd "$TARGET_DIR"

# Use wget to mirror pages (depth tuned; adjust as needed)
wget \
  --recursive \
  --no-clobber \
  --page-requisites \
  --html-extension \
  --convert-links \
  --restrict-file-names=unix \
  --domains www.kenpowerbooks.com \
  --no-parent \
  --level=3 \
  "$BASE_URL" || true

# Optional: prune query strings from filenames (example placeholder)
# find . -type f -name '*?*' -exec bash -c 'for f; do nf="${f%%\?*}"; mv "$f" "$nf" 2>/dev/null || true; done' _ {} +

cat <<EOF
Mirror attempt complete. Review the directory structure. You may want to:
  * Increase --level if deeper pages are missing.
  * Manually curate navigation or generate a sitemap.
  * Run a link checker: e.g., npx broken-link-checker .
EOF
