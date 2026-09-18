-- Structure of the invariant family on the 9-orbit generators: do the deformed generators factor as x_p * C_i(t)?
-- Usage: M2 --script scripts/cubic_factor_structure.m2 certificates/lift6_state_order6.m2.txt 6
args = commandLine; statefile = args#(#args-2); N = value args#(#args-1);
SB = QQ[t_1, t_2, x_1..x_9, Degrees => {{0,1},{0,1},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0},{1,0}}];
load statefile;
Ftot = sum apply(N+1, k -> value("F_"|toString k));
gensList = flatten entries F_0;
nine = {0,1,2,15,25,32,33,34,35};  -- indices of the 9-orbit generators (x1x2x3 x_p, x_p x7x8x9, x4x5x6 x_p)
for j in nine do (
    f := Ftot_(0,j); m := gensList#j;
    -- the variable p that is the "point": the variable of m not in the row triple
    fac := factor f;
    stdio << "generator " << toString m << " : factors " << toString apply(toList fac, t -> (toString t#0, t#1)) << endl;
    );
-- print the three cubics C_1, C_2, C_3 (up to t-order N)
C1 := Ftot_(0,0) // x_4; C2 := Ftot_(0,33) // x_7; C3 := Ftot_(0,15) // x_1;
stdio << "C_1 = " << toString C1 << endl;
stdio << "C_2 = " << toString C2 << endl;
stdio << "C_3 = " << toString C3 << endl;
assert(Ftot_(0,0) == x_4 * C1); assert(Ftot_(0,1) == x_5 * C1); assert(Ftot_(0,2) == x_6 * C1);
assert(Ftot_(0,33) == x_7 * C2); assert(Ftot_(0,34) == x_8 * C2); assert(Ftot_(0,35) == x_9 * C2);
assert(Ftot_(0,15) == x_1 * C3); assert(Ftot_(0,25) == x_2 * C3); assert(Ftot_(0,32) == x_3 * C3);
stdio << "CHECK|nine_orbit_generators_factor_as_x_p_times_cubic|true" << endl;
-- 27-orbit representative
stdio << "27-orbit representative x_1x_2x_4x_8 deformed: " << toString Ftot_(0,3) << endl;
stdio << "CUBIC_FACTOR_DONE" << endl;
exit 0;
