# Is the link of vertex 9 in Delta (9-vertex CP^2) isomorphic to the packet's 8-vertex sphere M
# (Stanley-Reisner ideal I_M with 16 cubic generators, grunbaum-zero-context-proof/gs_tangent.m2)?
# Pure Python, exact. Also identifies the stabiliser S_3 of vertex 9 with the packet's group G on {a..h}.
import itertools, json, sys
facets=[]
for line in open("data/facets_chapoton_manivel_1109.6490v1.txt"):
    line=line.strip()
    if not line or line.startswith("#"): continue
    for tok in line.split(): facets.append(frozenset(int(c) for c in tok))
assert len(facets)==36
def link(v):
    return [F-{v} for F in facets if v in F]
def nonfaces_min(fac, verts, k):
    faces=set()
    for F in fac:
        for r in range(1,len(F)+1):
            for s in itertools.combinations(sorted(F),r): faces.add(frozenset(s))
    return sorted([frozenset(s) for s in itertools.combinations(sorted(verts),k) if frozenset(s) not in faces], key=sorted)
L9=link(9); assert len(L9)==20
V9=sorted(set().union(*L9)); assert V9==list(range(1,9))
nf3=nonfaces_min(L9,V9,3)
print("link_9_facets",len(L9),"minimal_nonface_triples",len(nf3))
# packet sphere: I_M generators on a..h
packet="a*b*f,a*b*g,a*b*h,a*c*g,a*c*h,a*d*h,b*d*f,b*d*g,b*e*g,c*d*e,c*e*g,c*e*h,c*f*h,d*e*f,d*f*h,e*f*g"
gensM=[frozenset(t.split("*")) for t in packet.split(",")]
assert len(gensM)==16
letters="abcdefgh"
# facets of M: 4-subsets of {a..h} containing no generator support
facM=[frozenset(s) for s in itertools.combinations(letters,4) if not any(g<=frozenset(s) for g in gensM)]
print("packet_sphere_facets",len(facM))
# search for an isomorphism vertices 1..8 -> a..h mapping facets of link(9) onto facets of M
target=set(facM)
isos=[]
for perm in itertools.permutations(letters):
    m={i+1:perm[i] for i in range(8)}
    if set(frozenset(m[v] for v in F) for F in L9)==target: isos.append(m)
print("number_of_isomorphisms_link9_to_M",len(isos))
if isos:
    m=isos[0]; print("one_isomorphism",{k:m[k] for k in sorted(m)})
    # stabiliser of 9 in Aut(Delta) transported to {a..h}
    perms=[]
    for line in open("data/group_Aut54.txt"):
        line=line.strip()
        if not line or line.startswith("#"): continue
        perms.append(tuple(int(c) for c in line.split()))
    stab=[g for g in perms if g[8]==9]
    print("stabiliser_order",len(stab))
    imgs=[]
    for g in stab:
        # induced permutation on a..h: letter m[v] -> m[g(v)]
        s="".join(m[g[letters.index(ch)+1 if False else [k for k in m if m[k]==ch][0]-1]] for ch in letters)
        imgs.append(s)
    print("stabiliser_as_strings_on_abcdefgh",sorted(imgs))
    print("packet_G_strings",sorted("abcdefgh ahgfedcb ceafbdgh chgdbfae gbcfhdae geadhfcb".split()))
    print("same_group_as_packet_G",sorted(imgs)==sorted("abcdefgh ahgfedcb ceafbdgh chgdbfae gbcfhdae geadhfcb".split()))
json.dump({"link9_facets":[sorted(F) for F in L9],"minimal_nonfaces":[sorted(F) for F in nf3],"isomorphisms_to_packet_M":[{str(k):v for k,v in m.items()} for m in isos]},open("certificates/vertex_link_vs_packet_sphere.json","w"),indent=1)
print("VERTEX_LINK_DONE")
