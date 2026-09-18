-- Local cohomology / depth of A = QQ[x_1..x_9]/I_Delta and sheaf cohomology of X = Proj A,
-- to justify Hom_S(I,A)_0 = H^0(N_X) and Hilb(P^8) = graded deformations of A (RESULTS.md, part 4).
needsPackage "Depth";
S = QQ[x_1..x_9];
I=ideal(x_1*x_2*x_3*x_4,x_1*x_2*x_3*x_5,x_1*x_2*x_3*x_6,x_1*x_2*x_4*x_8,x_1*x_2*x_5*x_7,x_1*x_2*x_6*x_9,x_1*x_3*x_4*x_9,x_1*x_3*x_5*x_8,x_1*x_3*x_6*x_7,x_1*x_4*x_5*x_8,x_1*x_4*x_6*x_9,x_1*x_4*x_8*x_9,x_1*x_5*x_6*x_7,x_1*x_5*x_7*x_8,x_1*x_6*x_7*x_9,x_1*x_7*x_8*x_9,x_2*x_3*x_4*x_7,x_2*x_3*x_5*x_9,x_2*x_3*x_6*x_8,x_2*x_4*x_5*x_7,x_2*x_4*x_6*x_8,x_2*x_4*x_7*x_8,x_2*x_5*x_6*x_9,x_2*x_5*x_7*x_9,x_2*x_6*x_8*x_9,x_2*x_7*x_8*x_9,x_3*x_4*x_5*x_9,x_3*x_4*x_6*x_7,x_3*x_4*x_7*x_9,x_3*x_5*x_6*x_8,x_3*x_5*x_8*x_9,x_3*x_6*x_7*x_8,x_3*x_7*x_8*x_9,x_4*x_5*x_6*x_7,x_4*x_5*x_6*x_8,x_4*x_5*x_6*x_9);
A = S/I; X = Proj A;
stdio << "CHECK|dim_A|" << dim A << "  degree " << degree A << endl;
stdio << "CHECK|depth_A|" << depth(ideal vars A, A) << endl;
-- local cohomology of A via Ext duality: H^i_m(A) = Ext^{9-i}_S(A, S(-9))^vee ; report degrees of Ext^{9-i}(A,S) for i=1..4
for i from 1 to 4 do (E := Ext^(9-i)(S^1/I, S^1); stdio << "CHECK|Ext^" << 9-i << "_S(A,S)_is_zero|" << (E == 0) << "  (dual to H^" << i << "_m(A))" << endl; if E != 0 then stdio << "   degrees of generators: " << toString degrees E << endl;);
-- Hochster: for a triangulated closed 4-manifold, H^i_m(A) (i<5) lives in degree 0 and equals H~^{i-1}(Delta)
-- check via sheaf cohomology: H^i(X, O_X(d)) = H^{i+1}_m(A)_d for i >= 1
for i from 1 to 4 do (
    for d from -3 to 3 do (
        stdio << "CHECK|h^" << i << "(O_X(" << d << "))|" << rank HH^i(OO_X(d)) << endl;
    );
);
stdio << "CHECK|h^0(O_X)|" << rank HH^0(OO_X) << endl;
stdio << "CHECK|h^0(O_X(1))|" << rank HH^0(OO_X(1)) << "  A_1 = " << numColumns basis(1,A) << endl;
stdio << "CHECK|h^0(O_X(4))|" << rank HH^0(OO_X(4)) << "  A_4 = " << numColumns basis(4,A) << endl;
-- saturation: I is saturated
stdio << "CHECK|I_saturated|" << (saturate I == I) << endl;
-- Hilbert polynomial
hp = hilbertPolynomial(A, Projective => false);
stdio << "CHECK|hilbert_polynomial|" << toString hp << endl;
stdio << "CHECK|chi(O_X)|" << sub(hp, (ring hp)_0 => 0) << endl;
-- normal sheaf global sections: H^0(Hom(I/I^2, O_X)) computed as a sheaf on P^8 vs Hom_S(I,A)_0
needsPackage "VersalDeformations";
F0 = gens I;
T1 = normalMatrix({0},F0);
stdio << "CHECK|dim_Hom_S(I,A)_0|" << numColumns T1 << endl;
-- graded Hom module in degree 0 directly
HomIA = Hom(module I, A);
stdio << "CHECK|dim_Hom_module_degree0|" << numColumns basis(0, HomIA) << endl;
-- sheaf normal bundle sections: H^0(X, Hom(I/I^2, O_X)) computed as sheaf cohomology on X = Proj A
MI = module I; MI2 = module (I^2);
Mconormal = MI / MI2;            -- I/I^2 as S-module (killed by I)
MA = Mconormal ** A;             -- as A-module
HomN = Hom(MA, A^1);             -- graded module whose sheaf is the normal sheaf N_X
t = timing (h0N := rank HH^0(sheaf HomN));
stdio << "CHECK|h^0(N_X)_via_sheaf_on_X|" << h0N << "  time " << t#0 << endl;
stdio << "CHECK|Hom_module_degree0_equals_h0N|" << (h0N == numColumns basis(0, HomIA)) << endl;
stdio << "DEPTH_COHOMOLOGY_DONE" << endl;
exit 0;
