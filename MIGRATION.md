# Migration record

Prepared 2026-09-18. Public visibility was explicitly authorized by Dani, and
[danimalabares/crystal](https://github.com/danimalabares/crystal) was created.
No Mac-local directory or aliases have been modified.

## Provenance and completeness

- Source repository: [danimalabares/grunbaum-cy-geography-zero-context](https://github.com/danimalabares/grunbaum-cy-geography-zero-context).
- Source commit: [`dd0f3771ff3f5502a956231a4c69d896e10f4a71`](https://github.com/danimalabares/grunbaum-cy-geography-zero-context/commit/dd0f3771ff3f5502a956231a4c69d896e10f4a71),
  the current `main`/`HEAD` observed on 2026-09-18.
- Imported paths: `computations/crystallographic-links/` and
  `computations/space-group-cy3/`, retaining their exact paths.
- Imported files: **97**, totaling **4,110,129 bytes**. Every Git blob and file
  byte count was verified against the source tree. Executable/file modes are
  retained by the copy and recorded in the manifest.
- [source-manifest.json](migration/source-manifest.json) records every source path,
  Git blob SHA-1, SHA-256, byte count, and mode.
- This is a snapshot import with exact commit provenance. Source history remains
  in the original repository; unrelated research history is not imported.
- No original prompt or separate audit file was tracked inside either imported
  directory. Reports, source indexes, scripts, all tracked inputs, and all tracked
  outputs are included. No private transcript or correspondence was imported.
- `dani-explanations-request.md` is an exact copy of the supplied
  `dani-explanations-requirement.md` (2,406 bytes), SHA-256
  `602541cbda297308d6a7ac678879480d5e5d895897fbfdb2dbb5f13e8fec37e9`.
- The source `.gitignore` was retained at the root. No license was present in the
  source root, and no license has been assigned by this setup.

## Dependencies and paths

Both computation drivers resolve their package root from their own script path;
the imported directory layout is unchanged. No executable dependency on another
directory in the source repository was found in the scripts inspected for this
migration. The root README supplies reproduction commands that work from Crystal's
root. Imported reports and logs are frozen as historical evidence, including the
three known review flags in [STATUS.md](STATUS.md).

Dependencies:

| Operation | Required dependencies |
| --- | --- |
| Verify import | Python 3, standard library |
| Stage-one space-group computation from tracked inputs | Python 3, standard library |
| Crystallographic combinatorial checks | Python 3, `networkx`, `sympy` |
| Crystallographic deformation calculations | Macaulay2 (`M2`); original run records version 1.20 |
| Re-extract space-group database inputs | `spglib`; GAP packages Cryst/CrystCat (original run used Sage's GAP) |
| Re-extract literature inputs | Cached third-party PDFs/TeX, `pypdf`, and the extraction scripts' dependencies |

The space-group source manifest was committed upstream, but the cached
third-party documents were not; those bytes cannot be migrated from Git. Source
URLs and expected hashes remain available. Rebuilding from the tracked extracted
inputs does not require downloading those documents.

Historical references to `runs/` and source-repository records are provenance,
not runtime imports. They remain accessible in the [pinned source tree](https://github.com/danimalabares/grunbaum-cy-geography-zero-context/tree/dd0f3771ff3f5502a956231a4c69d896e10f4a71),
including the [nine-vertex equivariant computation](https://github.com/danimalabares/grunbaum-cy-geography-zero-context/tree/dd0f3771ff3f5502a956231a4c69d896e10f4a71/runs/cp2-nine-vertex-equivariant-t2-2026-09-09).

## Setup checks

- All 97 imported files match the source Git blobs and SHA-256 manifest.
- All 18 Python files parse; all 18 JSON files parse.
- The space-group `scripts/run_all.py` completed in a separate temporary copy in
  7.8 seconds and printed `ALL CHECKS PASSED`. Its [setup log](migration/setup-space-group-check.log)
  is included. The imported evidence was not overwritten.
- That success does not resolve the R32 export bug or the two mathematical
  review flags, and is not an independent audit of the algorithms or literature.
- The crystallographic runtime was not rerun: `networkx`, `sympy`, and Macaulay2
  are unavailable in this environment. Its scripts were inspected for paths and
  parsed, and its input/output bytes verified.
- Root-document relative links were checked after creating this record.
- No long search, new literature investigation, or mathematical expansion was run.

## Publication and local setup

- Public repository created: https://github.com/danimalabares/crystal
- Initial remote commit: `736772e807390019d20f197d6593ce88b35935b9`.
- The complete import is prepared locally but **has not been published**.
  GitHub connector writes returned HTTP 403; command-line pushing lacked a
  GitHub credential. User approval for public publication is explicit.
- The source repository is unchanged. A reviewed source-migration patch is
  supplied in the terminal handoff, to apply only after verifying the destination.
- Terminal Claude should publish this snapshot, verify its 97 imported files,
  apply the source migration with concurrency checks, and record both commit IDs.
- Mac-local clone and `$alias` installation remain pending. See
  [LOCAL_SETUP.md](docs/LOCAL_SETUP.md).
