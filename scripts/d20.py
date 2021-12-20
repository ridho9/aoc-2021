import sys
from collections import defaultdict

around = [(dr, dc) for dr in range(-1, 2) for dc in range(-1, 2)] 

def tobin(num):
    res = 0
    for n in num:
        res *= 2
        if n == '#':
            res += 1
    return res

def idxaround(d, r, c):
    return [d[dr+r, dc+c] for (dr, dc) in around]

def doiter(gd, mapping, n):
    for iter in range(n):
        if mapping[0] == '.':
            newgd = defaultdict(lambda: '.', gd)
        else:
            newgd = defaultdict(lambda: mapping[len(mapping)-1] if iter%2==0 else mapping[0], gd)
        toeval = set((dr+r, dc+c) for (dr, dc) in around for (r, c) in newgd)
        gd = {ev: mapping[tobin(idxaround(newgd, *ev))] for ev in toeval}

    return sum(1 for v in gd.values() if v == "#")

with open(sys.argv[1]) as f:
    file = [s.strip() for s in f.readlines()]
mapping, grid = file[0], file[2:]
nr, nc = len(grid), len(grid[0])
gd = {(r, c): grid[r][c] for r in range(nr) for c in range(nc)}

print("p1", doiter(gd, mapping, 2))
print("p1", doiter(gd, mapping, 50))


