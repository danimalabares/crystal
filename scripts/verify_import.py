#!/usr/bin/env python3
"""Check byte-for-byte preservation of the imported research snapshot."""
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[1]
manifest = json.loads((ROOT / "migration/source-manifest.json").read_text())
errors = []
for item in manifest["files"]:
    path = ROOT / item["path"]
    if not path.is_file():
        errors.append(f"missing: {item['path']}")
        continue
    data = path.read_bytes()
    digest = hashlib.sha256(data).hexdigest()
    git_digest = hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()
    if len(data) != item["bytes"] or digest != item["sha256"] or git_digest != item["git_blob_sha1"]:
        errors.append(f"changed since import: {item['path']}")
if errors:
    raise SystemExit("\n".join(errors))
print(f"PASS: {len(manifest['files'])} imported files match source {manifest['source_commit']}")
print("This checks import integrity, not mathematical correctness.")
