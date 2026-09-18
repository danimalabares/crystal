-- Traces of one representative of each of the 10 conjugacy classes of H = Aut(Delta) on (T^1_A)_0 = Hom_S(I,A)_0 (93)
-- and on (T^2_A)_0 (126), with the same constructions as the verified historical script equivariant_t2.m2,
-- so that both spaces can be decomposed into H-irreducibles (representation data requested by Galkin).
-- Class representatives: from certificates/characters.json (Sage/GAP conjugacy classes).
needsPackage "VersalDeformations";
eq = (X,Y) -> (entries X == entries Y);
S=QQ[x_1..x_9];
I=ideal(x_1*x_2*x_3*x_4,x_1*x_2*x_3*x_5,x_1*x_2*x_3*x_6,x_1*x_2*x_4*x_8,x_1*x_2*x_5*x_7,x_1*x_2*x_6*x_9,x_1*x_3*x_4*x_9,x_1*x_3*x_5*x_8,x_1*x_3*x_6*x_7,x_1*x_4*x_5*x_8,x_1*x_4*x_6*x_9,x_1*x_4*x_8*x_9,x_1*x_5*x_6*x_7,x_1*x_5*x_7*x_8,x_1*x_6*x_7*x_9,x_1*x_7*x_8*x_9,x_2*x_3*x_4*x_7,x_2*x_3*x_5*x_9,x_2*x_3*x_6*x_8,x_2*x_4*x_5*x_7,x_2*x_4*x_6*x_8,x_2*x_4*x_7*x_8,x_2*x_5*x_6*x_9,x_2*x_5*x_7*x_9,x_2*x_6*x_8*x_9,x_2*x_7*x_8*x_9,x_3*x_4*x_5*x_9,x_3*x_4*x_6*x_7,x_3*x_4*x_7*x_9,x_3*x_5*x_6*x_8,x_3*x_5*x_8*x_9,x_3*x_6*x_7*x_8,x_3*x_7*x_8*x_9,x_4*x_5*x_6*x_7,x_4*x_5*x_6*x_8,x_4*x_5*x_6*x_9);
F0=gens I; n=numColumns F0; A=S/I;
R=gens ker F0; l=numColumns R;
kos=koszul(2,F0);
M2mod = Hom((image R/image kos),A)/(image substitute(transpose R,A));
T2 = lift(ambient basis(0,M2mod),S);
T1 = normalMatrix({0},F0);
d2=numColumns T2; d1=numColumns T1;
N = image map(A^l,A^n,sub(transpose R,A));
nf = X -> lift((map(A^l,A^(numColumns X),sub(X,A))) % N, S);
T2nf = nf T2;
allMonos = (X) -> unique flatten apply(numRows X, k-> flatten entries (coefficients(X^{k}))_0);
stackRows = (X,monos) -> matrix{{fold((a,b)->a||b, apply(numRows X, k -> lift((coefficients(X^{k},Monomials=>monos))_1,QQ)))}};
monos2 = allMonos T2nf;
T1nf = lift((map(A^n,A^d1,sub(T1,A))) % (image map(A^n,A^0,0)),S);
monos1 = allMonos T1nf;
reps = {{1,2,3,4,5,6,7,8,9},{1,2,3,5,6,4,9,7,8},{1,3,2,4,6,5,7,9,8},{2,3,1,5,6,4,8,9,7},{4,5,6,7,8,9,1,2,3},{4,5,6,8,9,7,3,1,2},{4,6,5,7,9,8,1,3,2},{7,8,9,1,2,3,4,5,6},{7,8,9,2,3,1,6,4,5},{7,9,8,1,3,2,4,6,5}};
sizes = {1,6,9,2,3,6,9,3,6,9};
gensList = flatten entries F0;
permMap = g -> map(S,S,apply(9,i->S_(g#i-1)));
genPerm = g -> apply(gensList, m -> position(gensList, mm -> mm == (permMap g) m));
permMatrix = pi -> matrix apply(n,i->apply(n,j-> if pi#j==i then 1_S else 0_S));
inverse2 = g -> apply(9, i -> position(g, v -> v==i+1)+1);
for ci from 0 to 9 do (
    g = reps#ci; h = inverse2 g;
    phig = permMap g; phih = permMap h;
    pig = genPerm g; pih = genPerm h;
    Pg = permMatrix pig; Ph = permMatrix pih;
    Rh = map(target R, S^(numColumns R), Ph * phih(R));
    Ch = Rh // R; assert(eq(R*Ch, Rh));
    gT2 = map(S^l, S^d2, transpose(phig(Ch)) * phig(T2));
    gT2nf = nf gT2;
    monosAll = unique(monos2 | allMonos gT2nf);
    Ta = stackRows(T2nf,monosAll); Pa = stackRows(gT2nf,monosAll);
    Mg2 = Pa // Ta; assert(eq(Ta*Mg2, Pa));
    gT1 = map(S^n, S^d1, Pg * phig(T1));
    gT1nf = lift((map(A^n,A^d1,sub(gT1,A))) % (image map(A^n,A^0,0)),S);
    monosAll1 = unique(monos1 | allMonos gT1nf);
    Ta1 = stackRows(T1nf,monosAll1); Pa1 = stackRows(gT1nf,monosAll1);
    Mg1 = Pa1 // Ta1; assert(eq(Ta1*Mg1, Pa1));
    stdio << "CLASS|" << ci << "|size|" << sizes#ci << "|rep|" << toString g << "|traceT2|" << trace Mg2 << "|traceT1|" << trace Mg1 << endl;
    );
stdio << "CLASS_CHARACTERS_DONE" << endl;
exit 0;
