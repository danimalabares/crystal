-- Finite-jet generic-smoothness certificate (q-adic chart criterion) for the Aut(Delta)-invariant family
-- restricted to the line (t_1,t_2) = (q, c*q), on the chart x_9 = 1 (all nine charts are equivalent under
-- the vertex-transitive group, and the family is exactly invariant).
-- Rank test: choose a random 4 x 36 matrix L over the field; g = L*f (4 polynomials); rank Jac_y(g) <= 3 at a point
-- iff there is lambda != 0 with Jac_y(g)^T lambda = 0.  Since rank Jac(g) <= rank Jac(f), the certificate
--     q^e  in  K + (q^(e+1)),  K = (f, Jac(g)^T*lambda, q^(N+1), lambda_i - 1)   for every lambda-chart i = 1..4
-- proves rank Jac(f) >= 4 at every point of the generic fibre with integral coordinates in this chart.
-- Usage: M2 --script scripts/chart_certificate.m2 <statefile> <N> <c> <p>      (p = 0 means QQ)
args = commandLine; statefile = args#(#args-4); N = value args#(#args-3); cval = value args#(#args-2); pchar = value args#(#args-1);
SB = QQ[t_1, t_2, x_1..x_9, Degrees => {{0,1},{0,1},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0}}];
load statefile;   -- defines V2, F_0..F_N, R_0..R_N over SB
Ftot = sum apply(N+1, k -> value("F_"|toString k));
kk = if pchar == 0 then QQ else ZZ/pchar;
T = kk[q, y_1..y_8, l_1..l_4, MonomialOrder => GRevLex];
-- x_9 = 1, t_1 = q, t_2 = c*q
toT = map(T, SB, {q, cval*q, y_1, y_2, y_3, y_4, y_5, y_6, y_7, y_8, 1});
f = toT Ftot;   -- 1 x 36
setRandomSeed("cp2-nine-2026-09-10");
L = random(kk^4, kk^36);
g = f * transpose L;   -- 1 x 4
Jg = jacobian(g);      -- rows: all variables of T; keep only y-rows
Jy = Jg^{1..8};        -- 8 x 4
lam = transpose matrix{{l_1, l_2, l_3, l_4}};
eqs = Jy * lam;        -- 8 x 1
Kbase = ideal f + ideal eqs + ideal(q^(N+1));
stdio << "chart x_9=1, line t=(q," << cval << "q), order " << N << ", field " << toString kk << endl;
results = {};
for i from 1 to 4 do (
    Ki := Kbase + ideal(T_(8+i) - 1);
    found := null;
    for e from 1 to N do (
        if found === null then (
            tm := timing (Ge := gb(Ki + ideal(q^(e+1))); r := (q^e) % Ge);
            stdio << "  lambda-chart " << i << " e=" << e << " q^e in K+(q^(e+1)): " << (r == 0) << "  (" << tm#0 << " s)" << endl;
            if r == 0 then found = e;
        );
    );
    results = append(results, found);
    stdio << "CHECK|lambda_chart_" << i << "_certificate_e|" << toString found << endl;
);
stdio << "CHECK|all_lambda_charts_certified|" << all(results, r -> r =!= null) << endl;
stdio << "CHART_CERTIFICATE_DONE" << endl;
exit 0;
