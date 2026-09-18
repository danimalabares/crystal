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
| CP²₉ nine-vertex triangulation: Hilbert-scheme tangent/obstruction | [Normal-sections package](computations/cp29-normal-sections/README.md): h⁰(N_X) = 93 against an 84-dimensional smooth embedded Kummer locus (compatible, not obstructive); [equivariant T¹/T²](runs/cp2-nine-vertex-equivariant-t2-2026-09-09/RESULTS.md): dim T¹₀ = 93, dim T²₀ = 126, `Aut(Δ)`-invariant `T²` = 0; [invariant-smoothing follow-up](runs/cp2-nine-vertex-invariant-smoothing-2026-09-10/RESULTS.md): the `H`-fixed Hilbert-scheme locus is smooth of dimension 5, with an unfinished chart-smoothness certificate | Reconcile with the crystallographic-links branch (same `Δ`); the questions in [KAPUSTKA_QUESTIONS.md](runs/cp2-nine-vertex-invariant-smoothing-2026-09-10/KAPUSTKA_QUESTIONS.md) are still open | Awaiting adaptation to the Dani requirement; no claim of confirmed understanding |
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

# Recompute the CP2_9 normal-sections package (standard library only, a few seconds).
python3 computations/cp29-normal-sections/check.py

# The original CP2_9 Hilbert-dimension audit and equivariant T1/T2 computation must be run
# together and from the repository root, because the former reads a file committed under
# the latter's directory:
python3 runs/cp2-nine-hilbert-dimension-audit-2026-09-10/check.py
python3 runs/cp2-nine-vertex-equivariant-t2-2026-09-09/scripts/verify_input.py   # from that directory
# See that run's own REPRODUCE.md for the Macaulay2 steps (about 4 minutes with M2 1.20).
```

`runs/cp2-nine-vertex-invariant-smoothing-2026-09-10/` has its own `REPRODUCE.md`
(SageMath/GAP and several Macaulay2 steps, roughly 45 minutes; one step is a documented
17-hour attempt that was killed without output and should not be repeated).

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
