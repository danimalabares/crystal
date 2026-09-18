# Reproduce

All commands from this run directory. Software: Macaulay2 1.20 (+ VersalDeformations 3.0, Depth), SageMath 10.7 (GAP),
Python 3.11.4 (`fractions` only), macOS 12.7.6, 4 cores, 8 GB. Inputs copied read-only from
`../cp2-nine-vertex-equivariant-t2-2026-09-09/data/` (facets, 36 generators, the 54 permutations, orbitals).

```sh
# 0. historical verifiers (run in a scratch copy of the 2026-09-09 run; outputs were byte-identical) — logs/00_*
# 1. group, characters, decompositions (≈1 min)
sage scripts/characters.sage                                 > logs/characters.log
# 2. depth, local/sheaf cohomology, Hilbert polynomial, h^0(N_X) (≈2 min)
M2 --script scripts/depth_cohomology.m2                      > logs/depth_cohomology.log
# 3. invariant tangents + equivariant two-parameter lift through order N (N=2,4,6; ≈1–2 min each)
M2 --script scripts/invariant_lift.m2 6 certificates/lift6   > logs/invariant_lift_order6.log
# 4. independent exact verification of the order-6 state (pure Python, ≈10 min)
python3 -B scripts/verify_lift_state.py certificates/lift6_state_order6.m2.txt 6 > logs/verify_lift_state_order6.log
# 5. structure of the family, fixed loci, first-order flatness test
M2 --script scripts/cubic_factor_structure.m2 certificates/lift6_state_order6.m2.txt 6 > logs/cubic_factor_structure.log
M2 --script scripts/fixed_locus_test.m2 certificates/lift4_state_order4.m2.txt 4 1      > logs/fixed_locus_test_N4_c1.log
M2 --script scripts/linear_family_test.m2 certificates/lift2_tangents.m2.txt            > logs/linear_family_test.log   # ≈20 min
# 6. per-class traces on T^1, T^2 and their decomposition (≈5 min + 15 s)
M2 --script scripts/class_characters_T1_T2.m2                > logs/class_characters_T1_T2.log
sage scripts/decompose_T1_T2.sage                            > logs/decompose_T1_T2.log
# 7. vertex link vs packet sphere (pure Python, ≈1 min)
python3 -B scripts/vertex_link_vs_packet_sphere.py           > logs/vertex_link_vs_packet_sphere.log
# 8. UNFINISHED: chart smoothness certificate (killed after 17 h, 1.2 GB, no output)
M2 --script scripts/chart_certificate.m2 certificates/lift4_state_order4.m2.txt 4 1 32003
python3 scripts/hash_run.py                                  # HASH_MANIFEST.json
```

Expected decisive lines: `CHECK|dim_T1_0_invariants|5`, `CHECK|dim_coordinate_invariants|3`,
`CHECK|order_k_obstruction_vanishes|true` (k = 2..6), `CHECK|FR_vanishes_through_order|6`, `CHECK|FR_exact_zero|false`,
`CHECK|depth_A|3`, `CHECK|h^0(N_X)_via_sheaf_on_X|93`, `CHECK|hilbert_polynomial|(3/2)*i^4+(9/2)*i^2+3`,
`CHECK|E_1_local_ideal_mod_q^(N+1)|{a, 3*b^3+q, q^5}`, `CHECK|nine_orbit_generators_factor_as_x_p_times_cubic|true`,
`CHECK|all_F_k_exactly_invariant|True`, `CHECK|all_R_k_exactly_invariant|True`, `CHECK|denominators_only_2_and_3|True`.

Failed attempts and fixes (kept for the record): matrix equality in Macaulay2 compares degree bookkeeping, so the lift
script uses entrywise equality and explicit `map(target, …)` before `//`; quotient rings rebind variable symbols
(`t_1` → `SB_0`, `Q = A1/J1loc` removed); the Python verifier's first version used the inverse permutation convention for
`F` (its first log line `all_F_k_exactly_invariant|False` was a bug in the check, corrected; Macaulay2 had asserted the
identities directly). The 2026-09-08 guarded entry points were not touched. Workflow agents: 1 of 6 completed.
Unfinished: chart certificate (above). The corrected `verify_lift_state.py` completed at 07:44 on 2026-09-11 with every
check `True` (`logs/verify_lift_state_order6.log`).
