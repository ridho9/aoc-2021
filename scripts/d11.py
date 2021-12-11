import collections as coll
import sys
with open(sys.argv[1]) as f:
    input = [[ord(c)-48 for c in x.strip()] for x in f.readlines()]
nrow, ncol = len(input), len(input[0])

def step():
    visited = set()
    toCheck = coll.deque()

    for r in range(nrow):
        for c in range(ncol):
            input[r][c] += 1
            if input[r][c] > 9:
                toCheck.append((r, c))
    
    while len(toCheck) > 0:
        r, c = toCheck.popleft()
        if (r, c) in visited:
            continue
        visited.add((r, c))
        for dr in range(-1, 2):
            for dc in range(-1, 2):
                rr, cc = r+dr, c+dc
                if (cc<0) or (cc>=ncol) or (rr<0) or (rr>= nrow) or ((dr==0) and (dc==0)):
                    continue
                input[rr][cc] += 1
                if input[rr][cc] > 9 and not (rr, cc) in visited:
                    toCheck.append((rr, cc))

    count = 0
    for r, c in visited:
        count += 1
        input[r][c] = 0
    return count, visited

total, i = 0, 1
while True:
    step_count, step_visited = step()
    total += step_count
    if i == 100:
        print("P1", total)
    if len(step_visited) == (nrow*ncol):
        print("P2 sync at", i)
        break
    i += 1



