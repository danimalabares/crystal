# Status

Updated 2026-09-18. This is a setup and migration record, not a new mathematical
audit. All research conclusions below are attributed to the imported reports.
See [MIGRATION.md](MIGRATION.md) for the exact source commit and setup checks.

## Priorities

1. Make the existing work understandable using Dani's HP baseline, beginning with
   one explicit quotient and one elliptic-curve degeneration.
2. Repair the three known space-group review flags below before treating its
   report as ready for sharing.
3. Specify and check the proposed generalized Kummer fourfold degeneration and
   the claimed connection to Stanley–Reisner schemes.
4. Keep the 21 affine space-group cases, the unresolved crystallographic case,
   and the wallpaper classification as scoped follow-up tasks. No deadlines or
   additional computations are imposed by this list.

## Branches

| Branch | Recorded evidence | Unresolved question or blocker | Explanation status |
| --- | --- | --- | --- |
| Crystallographic links | [REPORT.md](computations/crystallographic-links/REPORT.md), scripts and outputs report four `(m,1)_0` constructions, `m=2,3,4,6`, yielding the same ten-vertex triangulation; `(3,3)_0` identifies the nine-vertex triangulation | Compatible triangulation for `(4,2)_1`; smoothability and Hodge numbers of the two new link schemes | Awaiting adaptation to the Dani requirement; no claim of confirmed understanding |
| Space-group threefolds | [REPORT.md](computations/space-group-cy3/REPORT.md) records 14 linear literature matches and matching computed Hodge numbers; [table](computations/space-group-cy3/table/space_groups_35.tsv) lists all 35 | Three review flags; 21 affine identifications and computations pending; deformation equivalences unresolved | Awaiting adaptation to the Dani requirement; no claim of confirmed understanding |
| Fourfold degeneration | Research objective; [reading leads](SOURCES.md) | Exact construction, extension to the singular fibre, and connection to the SR scheme need proof | Learning and formulation stage |
| Wallpaper surfaces | Supporting direction from two-dimensional crystallography | No complete, checked 17-row classification in this repository | Learning stage |

## Review flags in the imported space-group audit

These flags were checked against the imported files during setup; their
mathematical resolution is outside this migration.

1. **R32 export:** `output/zclass_matching.json` stores
   `"no unimodular intertwiner found"` under
   `R32_rhombohedral_setting_conjugator`. In `scripts/run_all.py`, the variable
   holding that conjugator is reused before export. Preserve the correct value,
   rerun, and verify the exported matrix. The driver can print `ALL CHECKS PASSED`
   despite this bug.
2. **Deformation equivalence:** the report says the 35 labels “certainly do not
   correspond to 35 distinct families.” This is not established by the recorded
   coincidence of Hodge numbers. The branch README already describes deformation
   equivalence as open; the report still needs correction.
3. **Fundamental group:** the report's simple-connectedness deduction relies on
   Armstrong and Kollár/Takayama statements that its source index says were not
   reread. Check the actual statements and hypotheses or qualify the conclusion.

No claim of novelty, classification of deformation families, or identification
with an SR smoothing follows from this setup.
