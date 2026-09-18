-- Is the first-order Aut(Delta)-invariant family already flat (i.e. does the linear family F0 + a v1 + b v2 have
-- the Hilbert function of A)?  Exact test over QQ at random rational parameters, plus dimension/degree.
-- Usage: M2 --script scripts/linear_family_test.m2 certificates/lift2_tangents.m2.txt
args = commandLine; tfile = args#(#args-1);
S = QQ[x_1..x_9];
I=ideal(x_1*x_2*x_3*x_4,x_1*x_2*x_3*x_5,x_1*x_2*x_3*x_6,x_1*x_2*x_4*x_8,x_1*x_2*x_5*x_7,x_1*x_2*x_6*x_9,x_1*x_3*x_4*x_9,x_1*x_3*x_5*x_8,x_1*x_3*x_6*x_7,x_1*x_4*x_5*x_8,x_1*x_4*x_6*x_9,x_1*x_4*x_8*x_9,x_1*x_5*x_6*x_7,x_1*x_5*x_7*x_8,x_1*x_6*x_7*x_9,x_1*x_7*x_8*x_9,x_2*x_3*x_4*x_7,x_2*x_3*x_5*x_9,x_2*x_3*x_6*x_8,x_2*x_4*x_5*x_7,x_2*x_4*x_6*x_8,x_2*x_4*x_7*x_8,x_2*x_5*x_6*x_9,x_2*x_5*x_7*x_9,x_2*x_6*x_8*x_9,x_2*x_7*x_8*x_9,x_3*x_4*x_5*x_9,x_3*x_4*x_6*x_7,x_3*x_4*x_7*x_9,x_3*x_5*x_6*x_8,x_3*x_5*x_8*x_9,x_3*x_6*x_7*x_8,x_3*x_7*x_8*x_9,x_4*x_5*x_6*x_7,x_4*x_5*x_6*x_8,x_4*x_5*x_6*x_9);
F0 = gens I;
load tfile;   -- defines Vinv, orbD, V2 over S (loaded before any quotient ring is created)
A = S/I; use S;
hA = apply(9, d -> numColumns basis(d, A));
stdio << "hilbert_function_A_0..8 " << toString hA << endl;
setRandomSeed 20260910;
for trial from 0 to 2 do (
    a := random(QQ); b := random(QQ);
    if trial == 0 then (a = 1; b = 0); if trial == 1 then (a = 0; b = 1);
    F := F0 + a * transpose V2_{0} + b * transpose V2_{1};
    J := ideal F;
    hJ := apply(9, d -> numColumns basis(d, S/J));
    stdio << "trial " << trial << " (a,b)=(" << a << "," << b << ") hilbert_function_0..8 " << toString hJ << " same_as_A " << (hJ == hA) << endl;
    stdio << "   dim " << dim J << " degree " << degree J << " (A: dim 5 degree 36)" << endl;
    );
-- also each of the five invariant directions alone
for j from 0 to 4 do (
    F := F0 + transpose Vinv_{j}; J := ideal F;
    hJ := apply(7, d -> numColumns basis(d, S/J));
    stdio << "Vinv column " << j << " hilbert_function_0..6 " << toString hJ << " same_as_A " << (hJ == take(hA,7)) << " dim " << dim J << " degree " << degree J << endl;
    );
stdio << "LINEAR_FAMILY_TEST_DONE" << endl;
exit 0;
