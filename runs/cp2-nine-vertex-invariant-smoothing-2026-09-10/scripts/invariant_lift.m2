-- Aut(Delta)-equivariant two-parameter formal deformation of A = QQ[x_1..x_9]/I_Delta,
-- built order by order with Reynolds averaging over the full group of order 54.
-- Usage: M2 --script scripts/invariant_lift.m2 <N> <outprefix>
--   N = highest t-order computed; every F_n, R_n is exactly H-invariant and F*R == 0 mod t^(N+1).
-- Conventions (exact, over QQ):
--   F0 = 36 quartic generators (row), R0 = gens ker F0 (36 x 90, linear), A = S/I.
--   g in H acts on S by x_i |-> x_(g(i)); P_g permutes generators so that g(F0) = F0 * P_g.
--   C_g scalar 90x90 with R0 * C_g = P_g * g(R0).
--   Action on pairs: g.(F,R) = (g(F) * P_g^T,  P_g * g(R) * C_g^(-1)); it fixes (F0,R0) and preserves F*R = 0.
needsPackage "VersalDeformations";
eq = (X,Y) -> (entries X == entries Y);   -- entrywise equality, ignoring degree bookkeeping of free modules
args = commandLine; N = value args#(#args-2); outprefix = args#(#args-1);
S = QQ[x_1..x_9];
I=ideal(x_1*x_2*x_3*x_4,x_1*x_2*x_3*x_5,x_1*x_2*x_3*x_6,x_1*x_2*x_4*x_8,x_1*x_2*x_5*x_7,x_1*x_2*x_6*x_9,x_1*x_3*x_4*x_9,x_1*x_3*x_5*x_8,x_1*x_3*x_6*x_7,x_1*x_4*x_5*x_8,x_1*x_4*x_6*x_9,x_1*x_4*x_8*x_9,x_1*x_5*x_6*x_7,x_1*x_5*x_7*x_8,x_1*x_6*x_7*x_9,x_1*x_7*x_8*x_9,x_2*x_3*x_4*x_7,x_2*x_3*x_5*x_9,x_2*x_3*x_6*x_8,x_2*x_4*x_5*x_7,x_2*x_4*x_6*x_8,x_2*x_4*x_7*x_8,x_2*x_5*x_6*x_9,x_2*x_5*x_7*x_9,x_2*x_6*x_8*x_9,x_2*x_7*x_8*x_9,x_3*x_4*x_5*x_9,x_3*x_4*x_6*x_7,x_3*x_4*x_7*x_9,x_3*x_5*x_6*x_8,x_3*x_5*x_8*x_9,x_3*x_6*x_7*x_8,x_3*x_7*x_8*x_9,x_4*x_5*x_6*x_7,x_4*x_5*x_6*x_8,x_4*x_5*x_6*x_9);
F0 = gens I; n = numColumns F0; assert(n == 36);
A = S/I;
R0 = gens ker F0; l = numColumns R0; assert(l == 90);
stdio << "generators " << n << " relations " << l << endl;
-- group elements (54 permutations, images of 1..9)
perms = apply(select(lines get "data/group_Aut54.txt", s -> #s > 0 and (first s) != "#"), s -> apply(separate(" ", s), value));
assert(#perms == 54);
gensList = flatten entries F0;
permMap = g -> map(S, S, apply(9, i -> S_(g#i-1)));
genPerm = g -> apply(gensList, m -> position(gensList, mm -> mm == (permMap g) m));
permMatrix = pi -> matrix apply(n, i -> apply(n, j -> if pi#j == i then 1_QQ else 0_QQ)); -- (P)_{pi(j),j} = 1
-- check: g(F0) = F0 * P_g  (column j of F0*P_g is F0_{pi(j)} ... verify directly)
Pg = apply(perms, g -> permMatrix genPerm g);
phig = apply(perms, g -> permMap g);
for gi from 0 to 53 do assert(eq((phig#gi)(F0), F0 * sub(Pg#gi, S)));
stdio << "generator_permutation_check true" << endl;
-- C_g: R0 * C_g = P_g * g(R0)
Cg = apply(54, gi -> ( X := map(target R0, S^l, sub(Pg#gi, S) * (phig#gi)(R0)); C := X // R0; assert(eq(R0 * C, X)); lift(C, QQ)));
Cginv = apply(Cg, C -> inverse C);
for gi from 0 to 53 do assert(Cg#gi * Cginv#gi == id_(QQ^l));
stdio << "relation_transport_check true" << endl;
-- ---------- invariant tangent directions ----------
T1 = normalMatrix({0}, F0); d1 = numColumns T1; assert(d1 == 93);
red = X -> lift(sub(X, A), S);   -- normal form mod I (I monomial: canonical)
act1 = (gi, v) -> red(sub(Pg#gi, S) * (phig#gi)(v));   -- action on a 36-column representative of Hom(I,A)_0
Rey1 = v -> red((1/54) * sum apply(54, gi -> act1(gi, v)));
T1inv = red matrix {{fold((a,b) -> a|b, apply(d1, j -> Rey1(T1_{j})))}};
-- coefficient matrix to find a basis
allMonos = X -> unique flatten apply(numRows X, k -> flatten entries (coefficients(X^{k}))_0);
stackRows = (X, monos) -> matrix{{fold((a,b) -> a||b, apply(numRows X, k -> lift((coefficients(X^{k}, Monomials => monos))_1, QQ)))}};
monosInv = allMonos T1inv;
Mc = stackRows(T1inv, monosInv);
stdio << "CHECK|dim_T1_0_invariants|" << rank Mc << endl;
assert(rank Mc == 5);
-- pick 5 independent columns
cols = {}; cur = map(QQ^(numRows Mc), QQ^0, 0);
for j from 0 to d1-1 do (if #cols < 5 then (test := cur | Mc_{j}; if rank test > #cols then (cols = append(cols, j); cur = test)));
Vinv = T1inv_cols;   -- 36 x 5 invariant representatives
stdio << "invariant_basis_columns " << toString cols << endl;
-- coordinate directions: orbital sums of derivations x_j d/dx_i
der = (i, j) -> transpose matrix{apply(gensList, m -> S_(j-1) * diff(S_(i-1), m))};
orbs = apply(select(lines get "data/orbitals_Aut54.txt", s -> #s > 0 and (first s) != "#"), s -> apply(separate(" ", s), t -> apply(separate(",", t), value)));
orbD = red matrix{{fold((a,b) -> a|b, apply(orbs, O -> sum apply(O, p -> der(p#0, p#1))))}};
monosC = unique(monosInv | allMonos orbD);
McC = stackRows(orbD, monosC); McV = stackRows(Vinv, monosC);
stdio << "CHECK|dim_coordinate_invariants|" << rank McC << endl;
assert(rank McC == 3);
-- choose two invariant directions completing C^H to T1^H: greedy over Vinv columns
cc = {}; curC = McC;
for j from 0 to 4 do (if #cc < 2 then (test := curC | McV_{j}; if rank test > rank curC then (cc = append(cc, j); curC = test)));
assert(#cc == 2); assert(rank curC == 5);
V2 = Vinv_cc;
stdio << "intrinsic_invariant_directions_columns " << toString cc << endl;
-- verify these are homomorphisms I -> A (kill syzygies) and invariant
assert(sub(transpose V2 * R0, A) == 0);
for gi from 0 to 53 do assert(eq(act1(gi, V2), V2));
stdio << "two_intrinsic_invariant_tangents_verified true" << endl;
-- orbit structure of the 36 generators under H
orbitsGen = {}; seen = set {};
for j from 0 to n-1 do (if not member(j, seen) then (O := unique apply(54, gi -> (genPerm perms#gi)#j); orbitsGen = append(orbitsGen, sort O); seen = seen + set O));
stdio << "generator_orbits " << toString apply(orbitsGen, O -> #O) << " representatives " << toString apply(orbitsGen, O -> gensList#(O#0)) << endl;
-- ---------- two-parameter lift over QQ[t_1,t_2] ----------
SB = QQ[t_1, t_2, x_1..x_9, Degrees => {{0,1},{0,1},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0}}];
IB = sub(I, SB); AB = SB/IB;
F0B = sub(F0, SB); R0B = sub(R0, SB);
PgB = apply(Pg, P -> sub(P, SB)); CginvB = apply(Cginv, C -> sub(C, SB)); CgB = apply(Cg, C -> sub(C, SB));
phiB = apply(perms, g -> map(SB, SB, {SB_0, SB_1} | apply(9, i -> SB_(g#i+1))));  -- SB_0=t_1, SB_1=t_2, SB_(i+1)=x_i
for gi from 0 to 53 do assert(eq((phiB#gi)(F0B), F0B * PgB#gi));
actF = (gi, Fn) -> (phiB#gi)(Fn) * transpose PgB#gi;
actR = (gi, Rn) -> PgB#gi * (phiB#gi)(Rn) * CginvB#gi;
ReyF = Fn -> (1/54) * sum apply(54, gi -> actF(gi, Fn));
ReyR = Rn -> (1/54) * sum apply(54, gi -> actR(gi, Rn));
isInvF = Fn -> all(54, gi -> eq(actF(gi, Fn), Fn));
isInvR = Rn -> all(54, gi -> eq(actR(gi, Rn), Rn));
Rt = sub(transpose R0B, AB);  -- AB^36 -> AB^90
F1 = SB_0 * transpose sub(V2_{0}, SB) + SB_1 * transpose sub(V2_{1}, SB);  -- 1 x 36
assert(isInvF F1);
X1 = map(target F0B, SB^l, -(F1 * R0B)); R1 = X1 // F0B; assert(eq(F0B * R1, X1));
R1 = ReyR R1; assert(eq(F0B * R1 + F1 * R0B, 0 * X1)); assert(isInvR R1);
Fs = {F0B, F1}; Rs = {R0B, R1};
stdio << "order 1 done: F1 terms " << toString apply(flatten entries F1, f -> #terms f) << endl;
timeUsed = 0;
for k from 2 to N do (
    tm := timing (
    rho := sum apply(k-1, i -> Fs#(i+1) * Rs#(k-1-i));   -- sum_{i=1}^{k-1} F_i R_{k-i}
    rhoA := sub(rho, AB);
    w := (map(target Rt, AB^1, -transpose rhoA)) // Rt;
    obstructionZero := eq(Rt * w, -transpose rhoA);
    stdio << "CHECK|order_" << k << "_obstruction_vanishes|" << obstructionZero << endl;
    assert(obstructionZero);
    Fk := transpose lift(w, SB);
    Xk := map(target F0B, SB^l, -(rho + Fk * R0B));
    Rk := Xk // F0B; assert(eq(F0B * Rk, Xk));
    Fk = ReyF Fk; Rk = ReyR Rk;
    assert(eq(F0B * Rk + Fk * R0B + rho, 0 * rho));
    assert(isInvF Fk); assert(isInvR Rk);
    Fs = append(Fs, Fk); Rs = append(Rs, Rk);
    );
    stdio << "order " << k << " done in " << tm#0 << " s; F_" << k << " nonzero entries " << number(flatten entries Fs#k, f -> f != 0) << " (mod I nonzero: " << number(flatten entries sub(Fs#k, AB), f -> f != 0) << "); R_" << k << " nonzero entries " << number(flatten entries Rs#k, f -> f != 0) << endl;
    );
Ftot = sum Fs; Rtot = sum Rs;
prod = Ftot * Rtot;
-- verify F*R == 0 modulo (t)^(N+1): every entry has no term of t-degree <= N
tdeg = f -> if f == 0 then infinity else min apply(terms f, m -> (degree m)#1);
minT = min apply(flatten entries prod, tdeg);
stdio << "CHECK|FR_vanishes_through_order|" << (minT - 1) << endl;
assert(minT > N);
stdio << "CHECK|FR_exact_zero|" << (prod == 0) << endl;
-- export state
f = openOut(outprefix | "_state_order" | toString N | ".m2.txt");
f << "-- Aut(Delta)-invariant two-parameter deformation through t-order " << N << "; ring QQ[t_1,t_2,x_1..x_9]" << endl;
f << "V2 = " << toString V2 << ";" << endl;
for k from 0 to N do f << "F_" << k << " = " << toString Fs#k << ";" << endl;
for k from 0 to N do f << "R_" << k << " = " << toString Rs#k << ";" << endl;
close f;
g = openOut(outprefix | "_tangents.m2.txt");
g << "-- five Aut(Delta)-invariant representatives in Hom_S(I,A)_0 (columns), normal forms mod I" << endl;
g << "Vinv = " << toString Vinv << ";" << endl;
g << "-- three invariant coordinate-change directions (orbital derivations applied to the generators, mod I)" << endl;
g << "orbD = " << toString orbD << ";" << endl;
g << "-- two chosen intrinsic invariant tangents (columns " << toString cc << " of Vinv)" << endl;
g << "V2 = " << toString V2 << ";" << endl;
close g;
stdio << "INVARIANT_LIFT_DONE" << endl;
exit 0;
