# Checkpoints (America/Sao_Paulo)

- 10:30 — run directory created; source states recorded (`SOURCE_STATE.json`); inputs read.
- 10:45 — historical verifiers (`verify_input.py`, `verify_certificate.py Aut54_generators 54`) re-run in a scratch copy; outputs byte-identical to the shipped ones (`logs/00_*`). Historical run directory untouched.
- 10:50–14:20 — **no computation**: the session was paused by the assistant's usage limit. The four-hour active budget is restarted at 14:21 (recorded, not hidden).
- 14:25 — launched `scripts/invariant_lift.m2` (order 2) and `scripts/characters.sage` in the background; literature/recheck workflow started.
- 14:50 — done: exact re-verification of the historical certificate; `characters.sage` (H ≅ F₃²⋊S₃, 10 classes, invariant dims 1/18/2/16, dim Hom_H(I₄,A₄)=345, generator orbits 9+27); `depth_cohomology.m2` (depth A = 3, H¹ₘ=H²ₘ=0, h¹(O_X(d))=0, h²(O_X)=h⁴(O_X)=1, χ=3, Hilbert polynomial (3/2)m⁴+(9/2)m²+3, h⁰(N_X)=93 by sheaf cohomology); `invariant_lift.m2` orders 2 and 4 (obstructions vanish, F·R ≡ 0 mod t⁵, exactly H-invariant generators and relations); vertex link of 9 ≅ packet sphere M with stabiliser = packet group G. Running: order-6 lift, chart certificate (mod 32003, N=4, line t₂=t₁), linear-family flatness test, literature/recheck workflow.
- 15:10 — order-6 lift done; verifier written; chart certificate running. Session paused by usage limit until 2026-09-11 07:41.
- 2026-09-11 07:41 — chart certificate killed (17 h, no output); class traces and T¹/T² decompositions done; linear
  families not flat; literature workflow: 1/6 agents completed. Documents written (`RESULTS.md`, `DANI_EXPLANATION.md`,
  `KAPUSTKA_QUESTIONS.md`, `REPRODUCE.md`); `verify_lift_state.py` relaunched with the corrected F-convention.
- 2026-09-11 07:45 — independent Python verification of the order-6 state complete (all checks True); manifest written; run closed. Nothing committed or pushed.
