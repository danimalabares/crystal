#!/usr/bin/env python3
"""Check byte-for-byte preservation of every imported research snapshot.

Reads every migration/source-manifest*.json file and checks each listed file's
byte count, SHA-256, and (when the manifest records one) Git blob SHA-1. A
manifest entry with git_blob_sha1 = null documents a file that was untracked
in the source repository at the time of import (no Git blob exists to check).
"""
from pathlib import Path
import hashlib
import json
import sys

ROOT = Path(__file__).resolve().parents[1]
manifest_paths = sorted((ROOT / "migration").glob("source-manifest*.json"))
if not manifest_paths:
    raise SystemExit("no migration/source-manifest*.json files found")

errors = []
total_files = 0
for manifest_path in manifest_paths:
    manifest = json.loads(manifest_path.read_text())
    for item in manifest["files"]:
        total_files += 1
        path = ROOT / item["path"]
        if not path.is_file():
            errors.append(f"missing: {item['path']} ({manifest_path.name})")
            continue
        data = path.read_bytes()
        digest = hashlib.sha256(data).hexdigest()
        ok = len(data) == item["bytes"] and digest == item["sha256"]
        if ok and item.get("git_blob_sha1"):
            git_digest = hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()
            ok = git_digest == item["git_blob_sha1"]
        if not ok:
            errors.append(f"changed since import: {item['path']} ({manifest_path.name})")
if errors:
    raise SystemExit("\n".join(errors))
sources = ", ".join(f"{json.loads(p.read_text()).get('source_commit') or 'untracked snapshot'} ({p.name})"
                     for p in manifest_paths)
print(f"PASS: {total_files} imported files across {len(manifest_paths)} manifest(s) match: {sources}")
print("This checks import integrity, not mathematical correctness.")
