# Decompose (T^1_A)_0 (93) and (T^2_A)_0 (126) into irreducibles of H using the per-class traces in
# logs/class_characters_T1_T2.log (Macaulay2) and the GAP character table (same class order as characters.sage).
import re
perms=[tuple(int(c) for c in l.split()) for l in open("data/group_Aut54.txt") if l.strip() and not l.startswith("#")]
G=PermutationGroup([Permutation(list(g)) for g in perms])
CC=G.conjugacy_classes(); irr=G.irreducible_characters()
rows=[]
for l in open("logs/class_characters_T1_T2.log"):
    m=re.match(r"CLASS\|(\d+)\|size\|(\d+)\|rep\|\{([^}]*)\}\|traceT2\|(-?\d+)\|traceT1\|(-?\d+)",l)
    if m: rows.append((int(m.group(2)),tuple(int(x) for x in m.group(3).split(",")),int(m.group(4)),int(m.group(5))))
assert len(rows)==10
# match each rep to a GAP class
idx=[]
for size,rep,t2,t1 in rows:
    g=G(Permutation(list(rep)))
    k=[i for i,c in enumerate(CC) if g in c]; assert len(k)==1 and len(CC[k[0]])==size; idx.append(k[0])
def decomp(vals):
    v=[None]*10
    for (size,rep,t2,t1),i in zip(rows,idx): v[i]=vals[rows.index((size,rep,t2,t1))]
    return [sum(len(CC[c])*v[c]*conjugate(psi.values()[c]) for c in range(10))/54 for psi in irr]
dT2=decomp([r[2] for r in rows]); dT1=decomp([r[3] for r in rows])
print("irreducible_degrees",[psi.degree() for psi in irr])
print("T1_decomposition",[str(x) for x in dT1]," check dim",sum(d*psi.degree() for d,psi in zip(dT1,irr)))
print("T2_decomposition",[str(x) for x in dT2]," check dim",sum(d*psi.degree() for d,psi in zip(dT2,irr)))
print("DECOMPOSE_DONE")
