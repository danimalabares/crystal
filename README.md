# Crystal

Crystallographic groups, complex quotients, triangulations, and degenerations.

**Start with [Dani's explanation requirement](dani-explanations-request.md).**
Understanding is part of the work. Imported AI reports are evidence to inspect,
not results Dani has automatically checked, understood, or endorsed.

## Project map

| Branch | Evidence and status | Next step |
| --- | --- | --- |
| Crystallographic triangulations and Stanley–Reisner schemes | [Imported computation](computations/crystallographic-links/README.md): four reported constructions of the ten-vertex complex projective plane; two link types; one unresolved case | Adapt the argument to Dani's HP baseline; review the open triangulation and smoothing questions |
| Space groups and Calabi–Yau threefolds | [Imported stage-one audit](computations/space-group-cy3/README.md): 14 linear cases; 21 affine cases pending | Resolve the three [review flags](STATUS.md#review-flags-in-the-imported-space-group-audit), then explain one complete example |
| Tate/Mumford degeneration and generalized Kummer fourfolds | Research objective, not an established construction in this repository | Work through an elliptic-curve degeneration and a product example; specify the proposed fourfold construction |
| Wallpaper groups and complex surfaces | Supporting learning direction; no verified 17-case table here | Explain the quotient construction using the undergraduate tiling background |

The long-term objective is to understand the proposed generalized Kummer
fourfold degeneration and its possible connection to Stanley–Reisner schemes.
This connection is not established by either imported computation.

- [STATUS.md](STATUS.md): evidence, blockers, priorities, and explanation status.
- [SOURCES.md](SOURCES.md): starting sources and inherited source indexes.
- [MIGRATION.md](MIGRATION.md): exact provenance, dependencies, and setup state.
- [docs/LOCAL_SETUP.md](docs/LOCAL_SETUP.md): installation at `~/dr/crystal` and the local `$alias` step.

## Reproduction

From the repository root:

```sh
# Verify the untouched imported snapshot (standard library only).
python3 scripts/verify_import.py

# Recompute the stage-one space-group audit (standard library only, about a minute).
python3 computations/space-group-cy3/scripts/run_all.py

# Combinatorial checks (requires networkx and sympy, several minutes).
python3 computations/crystallographic-links/scripts/run_all.py --no-m2
```

The computation drivers locate their inputs relative to their own files.
They overwrite recorded outputs. Work on a branch if preserving the imported
snapshot matters. The first command checks import integrity only, not mathematical
correctness. The space-group driver still contains the flagged R32 export bug.

Omit `--no-m2` to include Macaulay2 checks when `M2` is installed. Do not add
`--full-search` casually: the historical crystallographic search ran for 45 hours.
See the branch READMEs for dependencies needed to regenerate external source data.

## Working rules

Read [AGENTS.md](AGENTS.md) or [CLAUDE.md](CLAUDE.md), then the explanation
requirement, before mathematical work. Keep private correspondence and transcripts
out of the repository. Preserve imported evidence and record corrections with
their reasons. Do not infer deformation equivalence or novelty from matching
invariants.
