# CP²₉: do the `Aut(Δ)`-invariant deformations contain a smoothing?

Run `runs/cp2-nine-vertex-invariant-smoothing-2026-09-10` (work 2026-09-10 14:21–15:10 and 2026-09-11 07:41–08:00
America/Sao_Paulo; the rest of the nominal four-hour window was lost to two usage-limit pauses, recorded in
`CHECKPOINT.md`). Exact arithmetic throughout (Macaulay2 1.20, Sage 10.7/GAP, pure-Python `fractions`).
Sources: workspace `30dd90d…`, packet `ee984e95…` (clean, read only), heap-project `08a71077…`; `SOURCE_STATE.json`.
Historical run directories were read but never written.

## Verdict (one paragraph)

**Unresolved (category 4), with new exact structure.** The `H`-invariant deformations of `X = Proj A ⊂ ℙ⁸`
(`|H| = 54`) form a **smooth 5-dimensional germ of the Hilbert scheme's `H`-fixed locus** (3 dimensions are the
centraliser torus, 2 are genuine), so equivariant algebraization is automatic. An explicit `H`-invariant two-parameter
family was constructed through `t`-order 6, with all 36 generators and 90 relations, every obstruction class shown to
vanish, and exact invariance and flatness verified independently. Every necessary condition tested for a smooth invariant
fibre holds (fixed points of the order-3 translations become reduced; no local model is unsmoothable), but the
sufficient Jacobian certificate on a chart did **not** finish (killed after 17 h, 1.2 GB, no output), no fibre was shown
smooth, and no fibre was shown singular. Nothing here contradicts either a smoothing or a permanently singular flat
family.

## What was proved in this run (all exact, reproducible)

1. **Baseline re-verified.** Historical verifiers re-run in a scratch copy: byte-identical (`logs/00_*`). `93, 72, 21,
   126, 14, 0, 5, 3, 2` unchanged.
2. **Group and characters** (`scripts/characters.sage`, `certificates/characters.json`). `H ≅ F₃² ⋊ S₃` (GAP:
   `(C3×C3):C6`, same group), 10 conjugacy classes, irreducible degrees `1⁶,2³,6`. Permutation characters agree with the
   ChatGPT table row by row **but** the table's cycle-type rows are unions of classes: type `3³` = classes of sizes
   `2,3,6,3,6`, type `6·3` = two classes of size 9. Invariant dimensions `1, 18, 2, 16` for `V*, Sym⁴V*, I₄, A₄`;
   `dim Hom_H(I₄,A₄) = 345` (= dimension of the `H`-fixed Grassmannian through `[I₄]`; only 5 of these respect the
   syzygies). Generator orbits: **9 + 27** (not 18 + 18). Decompositions (`logs/decompose_T1_T2.log`, class traces in
   `logs/class_characters_T1_T2.log`): `Sym⁴V* = 18·1 + 5(χ₂+χ₃+χ₄) + 18(χ₅+χ₆) + 16(χ₇+χ₈+χ₉) + 55χ₁₀`,
   `I₄ = 2·1 + 2χ₅ + 2χ₆ + (χ₇+χ₈+χ₉) + 4χ₁₀`, `T¹ = 5·1 + 2χ₂ + χ₃ + χ₄ + 4χ₅ + 4χ₆ + 2χ₇ + 3χ₈ + 3χ₉ + 10χ₁₀` (93),
   `T² = 4(χ₂+χ₃+χ₄) + 5(χ₇+χ₈+χ₉) + 14χ₁₀` (126): the obstruction space contains **none** of the three characters
   occurring in `V*`.
3. **Hilbert-scheme comparison** (`scripts/depth_cohomology.m2`). `depth A = 3`; `H¹ₘ(A) = H²ₘ(A) = 0`, `H³ₘ(A) ≅ k` in
   degree 0, `H⁴ₘ(A) = 0` (Ext duality); `h¹(O_X(d)) = 0` (`|d| ≤ 3`), `h²(O_X) = h⁴(O_X) = 1`, `χ(O_X) = 3`; `I`
   saturated; Hilbert polynomial `(3/2)m⁴ + (9/2)m² + 3`. Consequences (argument in `DANI_EXPLANATION.md` §5):
   `T_{[X]}Hilb(ℙ⁸) = H⁰(N_X) = Hom_S(I,A)₀`, dimension **93 confirmed by sheaf cohomology**; the Hilbert functor at
   `[X]` equals the graded functor of `A`, so `(T²_A)₀` (126) is a complete obstruction space for `Hilb(ℙ⁸)` at `[X]`;
   hence **`Hilb(ℙ⁸)^H` is smooth of dimension 5 at `[X]`**, and the `S₃`-fixed locus has tangent dimension 23 with
   obstruction space of dimension 14 (undecided).
4. **Explicit invariant tangents** (`certificates/lift6_tangents.m2.txt`): `v_a` on the 9-orbit,
   `x₁x₂x₃x_p ↦ (1/3)x_p x₄x₅x₆` (cyclically `{123}→{456}→{789}→{123}`); `v_b` on the 27-orbit,
   `x₁x₂x₄x₈ ↦ (1/18)(x₁²x₆x₇ + x₂²x₅x₉)` and translates. Neither linear family `F₀ + a v_a + b v_b` is flat
   (`logs/linear_family_test.log`: Hilbert function deviates in degree 5), so higher-order terms are necessary.
5. **Invariant two-parameter family through order 6** (`scripts/invariant_lift.m2`, states
   `certificates/lift{2,4,6}_state_order*.m2.txt`; independent check `scripts/verify_lift_state.py`,
   `logs/verify_lift_state_order6.log`). At every order 2–6 the obstruction class is computed and is zero; `F_n, R_n`
   are Reynolds-averaged and exactly `H`-invariant (54 identities each); `F·R ≡ 0 mod (t₁,t₂)⁷`; all denominators are
   powers of 2 and 3; `R₂ = R₅ = 0`; `F₃…F₆` are supported on the 9-orbit. **Structure**: the nine 9-orbit generators
   factor exactly as `x_p·C_i(t)` with `C₁ = x₁x₂x₃ + s·x₄x₅x₆ + s²·x₇x₈x₉ − u²(Σ_{123}x³ + s Σ_{456}x³ + s²Σ_{789}x³)
   − 2u⁵(Σ_{123}x³ + sΣ_{456}x³ + s²Σ_{789}x³) + O(t⁷)`, `s = t₁/3`, `u = t₂/18` (`logs/cubic_factor_structure.log`):
   Hesse-pencil cubics. The 27-orbit generators deform by quartics only (`x₁x₂x₄x₈ + u(x₁²x₆x₇ + x₂²x₅x₉) +
   u²(x₂x₃x₆x₇ − x₃²x₄x₈ + x₁x₃x₅x₉) + …`). The small-extension argument for the two-variable base is in
   `DANI_EXPLANATION.md` §4.
6. **Necessary conditions for a smooth invariant fibre** (`scripts/fixed_locus_test.m2`). For the translation
   `g = (123)(456)(789)`, `X ∩ Fix(g)` is nine triple points; on the line `t₁ = t₂ = q` the local ideal is exactly
   `(a, 3b³ + q)` (eigenvalue 1) and `(a, b³ + q/3)` (eigenvalue ω) modulo `q⁵`: the fixed points become reduced
   (over `ℚ((q^{1/3}))`) at order one, for every continuation. Local models of `X`: at the nine vertices the affine cone
   over the Grünbaum threefold `X_M` (vertex link ≅ `M`, stabiliser = packet group `G`, six isomorphisms;
   `certificates/vertex_link_vs_packet_sphere.json`), normal crossings along the ℙ³'s, `xyz = 0` transversally along
   3-cycle triangles. No structural obstruction found.

## Not established / failed / unfinished

- **No smoothness certificate.** `scripts/chart_certificate.m2` (λ-vector Jacobian rank test, chart `x₉ = 1`, order
  4, line `t₂ = t₁`, mod 32003) ran 17 h at 1.2 GB without producing a Gröbner basis and was killed. The mod-`p`
  route would in any case have needed the `ℤ[1/6]`-integrality bridge (`DANI_EXPLANATION.md` §6).
- No fibre was shown singular either; the truncated jets cannot be specialised (not flat), so "singular examples" do
  not exist in this run.
- Literature workflow: only the IKKR agent completed (`logs/literature_workflow_output.json`, agent-collected, not
  second-checked). Its main correction: **IKKR arXiv:1603.00403 concerns K3^[2]-type fourfolds and Kummer quartic
  surfaces, not Kum₂ fourfolds in ℙ⁸**; the relevant sources it names are Britze–Nieper (RR), Rapagnetta (Fujiki
  constant 9), Agostini–Beri–Giovenzana–Ríos Ortiz arXiv:2505.14490 (degree-36 models of Jacobian Kummer fourfolds in
  ℙ⁸ with Heisenberg `H(3,3)` action, line bundles big and nef but not ample, no equations), Boissière–Nieper-
  Wißkirchen–Sankaran arXiv:2505.14444 (moduli dimension 4). It found no literature on degenerations to
  Stanley–Reisner schemes and no proof that the general square-2 Kum₂ fourfold embeds in ℙ⁸. The Kühnel–Banchoff,
  lattice-theory, independent-recheck and referee agents did not run (session limit).
- Kapustka's dimension argument: not recoverable from any available note; see `KAPUSTKA_QUESTIONS.md`.

## Next decisive step

The jets strongly suggest an **algebraic** family in the parameters `s = t₁/3`, `u = t₂/18` (coefficients of `C₁` look
like `−u²(1 + 2u³ + …)`, Hesse cubics `x₁x₂x₃`, `Σx³`). Compute orders 7–9 (seconds each), guess closed forms for the
36 generators, verify `F·R = 0` **exactly** (then the family is polynomial/rational and honestly flat), and test one
fibre over `𝔽_p` and over ℚ with the codimension-4 Jacobian criterion. If closed forms resist, run the chart
certificate in Singular over `𝔽_p` with the `S₃` symmetry of the chart and the torus used to normalise two parameters.
