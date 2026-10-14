#!/usr/bin/env python3
"""Check the unpacked data against MANIFEST.csv: python3 branch2024_data/verify_data.py [part ...]
With part numbers (for example `1 2`), only the files of those parts are checked; with
`--files LIST`, only the paths listed in LIST (one per line, relative to this folder)."""
import csv, hashlib, os, sys
base = os.path.dirname(os.path.abspath(__file__))
args = sys.argv[1:]
listed = None
if args[:1] == ["--files"]:
    listed = {l.strip() for l in open(args[1]) if l.strip()}
    args = args[2:]
only = {int(a) for a in args}
bad = ok = 0
seen = set()
for r in csv.DictReader(open(os.path.join(base, "MANIFEST.csv"))):
    if r["path"] in seen or (only and int(r["part"]) not in only) or (listed is not None and r["path"] not in listed):
        continue
    seen.add(r["path"])
    p = os.path.join(base, r["path"])
    if not os.path.isfile(p):
        print("missing:", p); bad += 1; continue
    h = hashlib.md5()
    with open(p, "rb") as f:
        for b in iter(lambda: f.read(1 << 22), b""):
            h.update(b)
    if h.hexdigest() != r["md5"]:
        print("checksum differs:", p); bad += 1
    else:
        ok += 1
print(f"{ok} files verified, {bad} problems")
