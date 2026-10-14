#!/bin/bash
# After cloning:  ./restore.sh DEST [part ...]
# Copies branch2024_data/ to DEST (a folder outside this clone; the same DEST for every repository of
# this data set), joins the files stored in 95 MiB pieces (GitHub takes files of at most 100 MiB),
# unpacks any .git folders stored as dot_git.tar, then checks the files against MANIFEST.csv: those of
# the given parts, or without parts those listed in CONTENTS.txt (the files this repository holds).
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
dest="${1:?usage: ./restore.sh DEST [part ...]}"
shift
mkdir -p "$dest"
cp -a "$here/branch2024_data/." "$dest/"
cd "$dest"
find . -name '*.piece1of*' -print0 | while IFS= read -r -d '' p1; do
  base="${p1%.piece1of*}"
  n="${p1##*.piece1of}"
  pieces=()
  for k in $(seq 1 "$n"); do pieces+=("$base.piece${k}of$n"); done
  cat "${pieces[@]}" > "$base"
  rm "${pieces[@]}"
done
find . -name dot_git.tar -print0 | while IFS= read -r -d '' t; do
  tar -xf "$t" -C "$(dirname "$t")"
  rm "$t"
done
if [ $# -gt 0 ]; then
  python3 verify_data.py "$@"
elif [ -f "$here/CONTENTS.txt" ]; then
  python3 verify_data.py --files "$here/CONTENTS.txt"
else
  python3 verify_data.py
fi
