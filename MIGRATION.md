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
- **Published.** The prepared snapshot was pushed as
  [`29a275a61c808bbd7778bb064a8e61b079b65ca2`](https://github.com/danimalabares/crystal/commit/29a275a61c808bbd7778bb064a8e61b079b65ca2)
  on `main`, from a Terminal Claude session on Dani's Mac with an authenticated
  `gh`/Git credential. `python3 scripts/verify_import.py` passed against all 97
  imported files before the commit; the pushed tree (109 files) was confirmed
  identical to the local working tree from a fresh read of the remote.
- The source migration was applied and pushed to
  [danimalabares/grunbaum-cy-geography-zero-context](https://github.com/danimalabares/grunbaum-cy-geography-zero-context)
  as [`a8f55bca41725711d0f98cde9061d42af661f23a`](https://github.com/danimalabares/grunbaum-cy-geography-zero-context/commit/a8f55bca41725711d0f98cde9061d42af661f23a),
  after confirming the source was still at the pinned commit
  `dd0f3771ff3f5502a956231a4c69d896e10f4a71` (no concurrent work), that the
  supplied `source-migration.patch` applied cleanly, and that
  `python3 scripts/make_manifest.py --verify` passed there afterward from a
  fresh clone. Source history is intact; the two directories are now navigation
  READMEs pointing at this repository. One tracked artifact,
  `computations/space-group-cy3/output/extract_crystcat.stderr.log` (0 bytes),
  was left in place there by the supplied patch rather than deleted; it is a
  byte-identical duplicate of the copy already imported here, so no content is
  lost, but the source directory is not fully empty of the migrated files.
- Mac-local clone and `$alias` installation: see [LOCAL_SETUP.md](docs/LOCAL_SETUP.md).

## Second migration batch (2026-09-18)

Prepared 2026-09-18, same authorization as above (public repository already exists).

### Provenance and completeness

- Source repository: [danimalabares/grunbaum-cy-geography-zero-context](https://github.com/danimalabares/grunbaum-cy-geography-zero-context).
- Source commit for the three tracked directories: [`a8f55bca41725711d0f98cde9061d42af661f23a`](https://github.com/danimalabares/grunbaum-cy-geography-zero-context/commit/a8f55bca41725711d0f98cde9061d42af661f23a),
  the `main`/`HEAD` observed on 2026-09-18 immediately before this batch's removal commit
  there (i.e., the commit that completed the first migration).
- Imported paths, retaining their exact repository-root-relative paths:
  `computations/cp29-normal-sections/`, `runs/cp2-nine-hilbert-dimension-audit-2026-09-10/`,
  `runs/cp2-nine-vertex-equivariant-t2-2026-09-09/`, `runs/cp2-nine-vertex-invariant-smoothing-2026-09-10/`.
- The first three were tracked in the source repository; every Git blob and byte count was
  verified against the source tree. [`migration/source-manifest-2.json`](migration/source-manifest-2.json)
  records 73 files, 1,387,090 bytes, with Git blob SHA-1, SHA-256, byte count, and mode for each.
- `runs/cp2-nine-vertex-invariant-smoothing-2026-09-10/` was **never committed** to the source
  repository (untracked local work; confirmed by `git status` there immediately before this
  migration). No Git blob provenance exists for it. [`migration/source-manifest-2-untracked.json`](migration/source-manifest-2-untracked.json)
  records 50 files, 467,362 bytes, with SHA-256, byte count, and mode (git blob field null),
  and the workspace commit its `SOURCE_STATE.json` says it started from
  (`30dd90dbdb69e14b1f52b2db70ca451d9281eda9`).
- 123 files, 1,854,452 bytes total, imported in this batch.
- This is a snapshot import with exact commit provenance for the tracked files and exact
  byte provenance (no Git history) for the untracked ones. Reports, source indexes, scripts,
  and all tracked inputs and outputs are included, including preserved failed and unfinished
  attempts (the quarantined linear-family test, the killed 17-hour chart-smoothness job, two
  early Macaulay2 development failures noted in the invariant-smoothing run's own records).
  No private transcript or correspondence was imported.

### A real cross-directory dependency (unlike the first batch)

`computations/cp29-normal-sections/historical/check.py` and
`runs/cp2-nine-hilbert-dimension-audit-2026-09-10/check.py` both read
`runs/cp2-nine-vertex-equivariant-t2-2026-09-09/data/minimal_nonfaces.json` via
`Path(__file__).resolve().parents[2]` resolved from the repository root, and
`runs/cp2-nine-vertex-invariant-smoothing-2026-09-10/REPRODUCE.md` copies its inputs from
`../cp2-nine-vertex-equivariant-t2-2026-09-09/data/`. All four directories were therefore
imported together, at their exact original repository-root-relative paths, in the same
commit. (Separately, `computations/cp29-normal-sections/historical/check.py`'s own `ROOT`
line resolves one directory too shallow — to `computations/`, not the repository root —
because it is an archival copy of the original script one directory deeper than its source;
this is a pre-existing latent bug in a frozen historical file, not touched here. The
*working* reproduction paths, `computations/cp29-normal-sections/check.py` (self-contained)
and `runs/cp2-nine-hilbert-dimension-audit-2026-09-10/check.py` (the original), were both
executed successfully; see Setup checks.)

### Dependencies

| Operation | Required dependencies |
| --- | --- |
| Verify import (all batches) | Python 3, standard library |
| CP²₉ normal-sections check | Python 3, standard library |
| CP²₉ Hilbert-dimension audit (original) | Python 3, standard library; must be run from the repository root with the equivariant-t2 run also present |
| CP²₉ equivariant T¹/T² computation | Python 3 (`verify_input.py`, `verify_certificate.py`); Macaulay2 1.20 for the M2 scripts |
| CP²₉ invariant-smoothing follow-up | Macaulay2 1.20 (+ VersalDeformations, Depth), SageMath 10.7 (GAP), Python 3 |

### Setup checks

- All 123 imported files in this batch match their manifests (Git blob SHA-1 where one
  exists, SHA-256, and byte count for all).
- 11 Python files and 30 JSON files in this batch parse without error.
- No script in this batch has a hardcoded absolute local path other than the standard
  `/Applications/Macaulay2-1.20/bin/M2` invocation already used throughout this repository's
  other runs; two frozen historical manifests (`computations/cp29-normal-sections/historical/run-manifest.json`,
  `runs/cp2-nine-hilbert-dimension-audit-2026-09-10/run-manifest.json`) record the original
  machine's path as data, consistent with how the source repository already treats its own
  historical run records, and were not rewritten.
- `python3 computations/cp29-normal-sections/check.py` was run from the imported checkout
  (its `fresh/` output is designed to be overwritten); the result was confirmed byte-identical
  to the already-committed `fresh/*.json`. Log: [`migration/setup-cp29-check.log`](migration/setup-cp29-check.log).
- In throwaway scratch copies (never inside the imported checkout): `runs/cp2-nine-hilbert-dimension-audit-2026-09-10/check.py`
  was run from a repository-root-shaped tree containing both `runs/` directories, and its
  output matched the committed `exact-check.json`/`tangent-basis.json` byte-for-byte;
  `runs/cp2-nine-vertex-equivariant-t2-2026-09-09/scripts/verify_input.py` and
  `scripts/verify_certificate.py` (both `G_S3` and `Aut54_generators`) were rerun and their
  outputs matched the committed data/certificate files byte-for-byte; Macaulay2 1.20's
  `scripts/t2_dims.m2` was rerun and independently reproduced `dim Hom_S(I,A)_0 = 93` and
  `dim (T²_A)_0 = 126`. Full log: [`migration/setup-cp29-family-check.log`](migration/setup-cp29-family-check.log).
- `runs/cp2-nine-vertex-invariant-smoothing-2026-09-10/` was **not** rerun: its full
  reproduction needs SageMath/GAP and roughly 45 minutes of Macaulay2 jobs, and one
  documented step is a 17-hour attempt killed without output that must not be repeated.
  Only byte identity and script/JSON parsing were checked for it, matching this migration's
  evidentiary bar (import integrity, not a mathematical audit or re-run).
- Root-document relative links were checked after creating this record (README.md, STATUS.md).
- No long search, new literature investigation, or mathematical expansion was run in this batch.

### Publication

- **Published.** This batch was committed to `main` as `<crystal-batch-2-commit>` (filled in
  after push below) and pushed. `python3 scripts/verify_import.py` (now checking all three
  manifests, 220 files total) passed before the commit.
- The corresponding source-repository removal was applied and pushed as
  `<source-batch-2-commit>` (filled in after push below), after confirming the source was
  still at the pinned commit `a8f55bca41725711d0f98cde9061d42af661f23a` (no concurrent work)
  and that `python3 scripts/make_manifest.py --verify` passed there afterward. This second
  batch also removed the two remaining redirect-README directories from the first migration
  (`computations/crystallographic-links/`, `computations/space-group-cy3/`, including the
  leftover empty `output/extract_crystcat.stderr.log`) and the untracked local third-party
  document cache under `computations/space-group-cy3/sources/`; the source repository's root
  `README.md`/`STATUS.md`/`PROOFS.md` links to Crystal are unchanged (they already pointed
  here) and now stand in place of any per-directory redirect file.
