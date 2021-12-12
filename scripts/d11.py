import collections as coll
import sys
import itertools
with open(sys.argv[1]) as f:
    input = [[ord(c)-48 for c in x.strip()] for x in f.readlines()]
nrow, ncol = len(input), len(input[0])
input = list(itertools.chain(*input))

def step():
    visited = set()
    toCheck = coll.deque()

    for r, c in [(r, c) for r in range(nrow) for c in range(ncol)]:
        p = r*nrow + c
        input[p] += 1
        if input[p] > 9:
            toCheck.append((r, c))
    
    while toCheck:
        r, c = toCheck.popleft()
        p = r*nrow + c
        if p in visited:
            continue
        visited.add(p)
        for dr in range(-1, 2):
            for dc in range(-1, 2):
                rr, cc = r+dr, c+dc
                pp = rr*nrow + cc
                if (cc<0) or (cc>=ncol) or (rr<0) or (rr>= nrow) or ((dr==0) and (dc==0)) or (pp in visited):
                    continue
                input[pp] += 1
                if input[pp] > 9:
                    toCheck.append((rr, cc))

    count = 0
    for p in visited:
        count += 1
        input[p] = 0
    return count
    # return len(visited)

total, i = 0, 1
while True:
    # print("step", i)
    step_count = step()
    total += step_count
    if i == 100:
        print("P1", total)

    passed = True
    for r,c in [(r, c) for r in range(nrow) for c in range(ncol)]:
        if input[r*nrow + c] != 0:
            passed = False
            break

    if passed:
        print("P2 sync at", i)
        break
    i += 1



