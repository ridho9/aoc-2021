import os, sys, math, itertools
from collections import defaultdict

with open(sys.argv[1]) as f:
    file = f.read().split("\n\n")
    scanners = [[tuple(int(n) for n in p.split(",")) for p in f.split("\n")[1:]] for f in file]

def refp(p): return tuple(reversed(p))

def dist2(p1, p2=[0,0,0], manhattan=False):
    s = 0
    for i in range(3):
        if manhattan:
            s += abs(p2[i] - p1[i])
        else:
            s += (p2[i] - p1[i])**2
    return s

def distance_matrix(points):
    return { frozenset([a, b]): dist2(points[a], points[b])
        for a in range(len(points))
            for b in range(len(points))
                if a != b}

def move_center(center, scanner):
    return [tuple(p[i] - center[i] for i in range(3)) for p in scanner]

def fline(s):
    return [list(s[i] & s[i+1])[0] for i in range(2)]

def genperm(points, idx):
    flip = idx % 6
    if flip == 0:
        points = [[x, y, z] for [x, y, z] in points]
    if flip == 1:
        points = [[z, y, -x] for [x, y, z] in points]
    if flip == 2:
        points = [[-x, y, -z] for [x, y, z] in points]
    if flip == 3:
        points = [[-z, y, x] for [x, y, z] in points]
    if flip == 4:
        points = [[y, -x, z] for [x, y, z] in points]
    if flip == 5:
        points = [[-y, x, z] for [x, y, z] in points]
    rot = idx // 6
    if rot == 0:
        points = [[x, z, -y] for [x, y, z] in points]
    if rot == 1:
        points = [[x, -y, -z] for [x, y, z] in points]
    if rot == 2:
        points = [[x, -z, y] for [x, y, z] in points]
    return [tuple(p) for p in points]

def join_scanner(scanner0, scanner1):
    scanner0 = [(0, 0, 0)] + scanner0
    scanner1 = [(0, 0, 0)] + scanner1
    dist0, dist1 = distance_matrix(scanner0), distance_matrix(scanner1)

    matches = [(k0, k1, v0)
        for k0, v0 in dist0.items()
            for k1, v1 in dist1.items()
                if v0 == v1]

    triangle = None
    for i in range(len(matches)):
        a0, a1, _ = matches[i]
        match_0 = set()
        match_1 = set()
        for j in range(len(matches)):
            if i == j: continue
            if not a0.isdisjoint(matches[j][0]):
                match_0.add(matches[j])
            if not a1.isdisjoint(matches[j][1]):
                match_1.add(matches[j])

        for m0, m1, _ in match_0 & match_1:
            tr0 = (m0 | a0).difference(m0 & a0)
            tr1 = (m1 | a1).difference(m1 & a1)
            if dist0[tr0] == dist1[tr1]:
                triangle = ([a0, m0, tr0], [a1, m1, tr1])
                break

        if triangle != None: break

    line0, line1 = [fline(s) for s in triangle]

    c0 = scanner0[line0[0]]
    mscanner0 = move_center(c0, scanner0)
    c1 = scanner1[line1[0]]
    mscanner1 = move_center(c1, scanner1)

    target = [mscanner0[line0[1]]]
    for idx in range(24):
        points = [mscanner1[line1[1]]]
        permed = genperm(points, idx)
        if target == permed:
            break

    mscanner1 = genperm(mscanner1, idx)
    bscanner0 = move_center(mscanner0[0], mscanner0)
    bscanner1 = move_center(mscanner0[0], mscanner1)

    bscanner0.pop(0)
    cs1 = bscanner1.pop(0)
    resscanner = list(set(bscanner0) | set(bscanner1))
    return (resscanner, cs1)

to_join = list(i + 1 for i in range(len(scanners) - 1))
centers = [(0, 0, 0)]
idx = 0
result = scanners[0]
while len(to_join) > 0:
    try:
        j = to_join[idx]
        result, center = join_scanner(result, scanners[j])
        centers.append(center)
        to_join.remove(j)
        idx = 0
    except:
        idx += 1
print("p1", len(result))

m = max(dist2(centers[a], centers[b], True)
    for a in range(len(scanners))
        for b in range(len(scanners))
            if a != b)
print("p2", m)