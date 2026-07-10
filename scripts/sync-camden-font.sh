#!/usr/bin/env bash
#
# sync-camden-font.sh — "the dance", automated.
#
# Copies the latest built Camden webfonts from the sibling camden-typeface repo
# into this site's public/fonts, then commits + pushes them on BOTH the work
# branch (e.g. dev) and the publish branch (main → triggers the live deploy).
#
# Usage:
#   scripts/sync-camden-font.sh ["commit message"]
#
# Run it from your work branch (dev). Requires a clean working tree so the
# branch switch is safe. Override the source dir with CAMDEN_TYPEFACE_WEBFONTS.
#
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

SRC="${CAMDEN_TYPEFACE_WEBFONTS:-$REPO_ROOT/../camden-typeface/fonts/webfonts}"
DEST="public/fonts"
FONTS=(Camden-Regular.woff2 Camden-Semibold.woff2)
MSG="${1:-Update Camden webfonts}"
PUBLISH_BRANCH="main"

# --- sanity checks --------------------------------------------------------
for f in "${FONTS[@]}"; do
  [[ -f "$SRC/$f" ]] || { echo "ERROR: source font not found: $SRC/$f" >&2; exit 1; }
done

WORK_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$WORK_BRANCH" == "$PUBLISH_BRANCH" ]]; then
  echo "ERROR: run this from your work branch (e.g. dev), not $PUBLISH_BRANCH." >&2
  exit 1
fi

# Guard against UNRELATED uncommitted changes. The Camden font files themselves
# are allowed to be pre-modified (the font build often drops them in already —
# that's exactly what we're syncing).
other="$(git status --porcelain | grep -vE 'public/fonts/Camden-(Regular|Semibold)\.woff2$' || true)"
if [[ -n "$other" ]]; then
  echo "ERROR: working tree has other uncommitted changes — commit or stash them first:" >&2
  echo "$other" >&2
  exit 1
fi

# --- copy the fonts in ----------------------------------------------------
declare -a paths=()
for f in "${FONTS[@]}"; do
  cp "$SRC/$f" "$DEST/$f"
  paths+=("$DEST/$f")
done

if git diff --quiet -- "${paths[@]}"; then
  echo "Fonts already up to date — nothing to do."
  exit 0
fi

# --- commit on the work branch --------------------------------------------
echo "==> $WORK_BRANCH: committing font update"
git add "${paths[@]}"
git commit -q -m "$MSG"
git push -q origin "$WORK_BRANCH"

# --- replicate onto the publish branch (deploys) --------------------------
echo "==> $PUBLISH_BRANCH: replicating + deploying"
git checkout -q "$PUBLISH_BRANCH"
git checkout "$WORK_BRANCH" -- "${paths[@]}"
if git diff --cached --quiet; then
  echo "    $PUBLISH_BRANCH already had these fonts — skipping."
else
  git commit -q -m "$MSG"
  git push -q origin "$PUBLISH_BRANCH"
fi
git checkout -q "$WORK_BRANCH"

echo "Done — $WORK_BRANCH and $PUBLISH_BRANCH updated; $PUBLISH_BRANCH deploy triggered."
