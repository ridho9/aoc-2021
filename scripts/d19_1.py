import os, sys, math
from collections import defaultdict

with open(sys.argv[1]) as f:
    file = f.read()
    file = file.split("\n\n")
    scanners = [[[int(n) for n in p.split(",")] for p in f.split("\n")[1:]] for f in file]

def refp(p):
    return tuple(reversed(p))

def dist2(p1, p2=[0,0,0]):
    s = 0
    for i in range(3):
        s += (p2[i] - p1[i])**2
    return s

def distance_matrix(points):
    result = defaultdict(lambda: -1)
    for a in range(len(points)):
        for b in range(len(points)):
            d = dist2(points[a], points[b])
            result[(a, b)] = d
            result[(b, a)] = d
    return result

distances = [distance_matrix(s) for s in scanners]

matches = []
distmatch = defaultdict(lambda: set())

evaluated0 = set()
for k0, v0 in distances[0].items():
    if k0 in evaluated0 or k0[0] == k0[1]:
        continue
    # print("evaluating s", 0, k0, v0)

    # find points in dist[1] that matches v
    evaluated1 = set()
    for k1, v1 in distances[1].items():
        if k1 in evaluated1 or k1[0] == k1[1]:
            continue
        if v0 == v1:
            # print("matches s1", k1, v1, v0)
            matches.append((k0, k1, v0))
        evaluated1.add(k1)
        evaluated1.add(refp(k1))

    evaluated0.add(k0)
    evaluated0.add(refp(k0))
    # break

# for m in matches:
#     print(m)

for i in range(len(matches)):
    a0, a1, v0 = matches[i]
    print(f"from first match {a0} {a1} {v0}")

    match_a = set()
    for j in range(len(matches)):
        b0, b1, v1 = matches[j]
        if i == j: continue
        if a0[0] in b0 or a0[1] in b0:
            # print("matches 0", b0, b1, v1)
            match_a.add((b0, b1, v1))

    match_b = set()
    for j in range(len(matches)):
        b0, b1, v1 = matches[j]
        if i == j: continue
        if a1[0] in b1 or a1[1] in b1:
            # print("matches 1", b0, b1, v1)
            match_b.add((b0, b1, v1))

    match_intersect = list(match_a.intersection(match_b))
    for m in match_intersect:
        print("from second match", m)

    break
