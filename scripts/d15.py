import collections, heapq, sys
with open(sys.argv[1]) as f:
    input = [[ord(c)-48 for c in x.strip()] for x in f.readlines()]
nrow, ncol = len(input), len(input[0])

def solve(map):
    nrow, ncol, picked, visited = len(map), len(map[0]), None, set()
    edge = [(0, (0, 0))] + [(10**6, (r, c)) for r in range(nrow) for c in range(ncol)]
    grid = {(r,c): map[r][c] for r in range(nrow) for c in range(ncol)}
    dist = collections.defaultdict(lambda: 10**6, {(0, 0): 0})

    while picked != (nrow - 1, ncol - 1):
        while True:
            mv, picked = heapq.heappop(edge)
            if picked in visited: continue
            break

        for (dr, dc) in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
            np = (dr+picked[0], dc+picked[1])
            if (np in visited) or (not np in grid): continue
            if mv + grid[np] < dist[np]:
                dist[np] = mv + grid[np]
                heapq.heappush(edge, (dist[np], np))

        visited.add(picked)

    return dist[picked]

print("p1", solve(input))

def calc(r, c):
    mulr, mulc = r // nrow, c // ncol
    dr, dc = r % nrow, c % ncol
    v = input[dr][dc] + mulr + mulc
    if v >= 10: v = (v%10) + 1
    return v

dilated = [[calc(r, c) for r in range(nrow*5)] for c in range(ncol*5)]
print("p2", solve(dilated))


