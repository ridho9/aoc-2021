import sys, re, collections

# shame

def addcube(nx0, nx1, ny0, ny1, nz0, nz1, nsgn, cubes):
    update = collections.Counter()

    for (ex0, ex1, ey0, ey1, ez0, ez1), esgn in cubes.items():
        ix0 = max(nx0, ex0); ix1 = min(nx1, ex1)
        iy0 = max(ny0, ey0); iy1 = min(ny1, ey1)
        iz0 = max(nz0, ez0); iz1 = min(nz1, ez1)
        if ix0 <= ix1 and iy0 <= iy1 and iz0 <= iz1:
            update[(ix0, ix1, iy0, iy1, iz0, iz1)] -= esgn
    if nsgn > 0:
        update[(nx0, nx1, ny0, ny1, nz0, nz1)] += nsgn
    cubes.update(update)

def sumcubes(cubes):
    return sum((x1 - x0 + 1) * (y1 - y0 + 1) * (z1 - z0 + 1) * sgn
          for (x0, x1, y0, y1, z0, z1), sgn in cubes.items())

cubes = collections.Counter()
with open(sys.argv[1]) as f:
    for line in f.readlines():
        nsgn = 1 if line.split()[0] == "on" else -1
        nx0, nx1, ny0, ny1, nz0, nz1 = map(int, re.findall("-?\d+", line))
        addcube(nx0, nx1, ny0, ny1, nz0, nz1, nsgn, cubes)


p2 = sumcubes(cubes)


addcube(-50, 50, -50, 50, -50, 50, -1, cubes)
p1 = p2 - sumcubes(cubes)
print("p1", p1)
print("p2", p2)