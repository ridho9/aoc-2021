import sys
from tqdm import tqdm
with open(sys.argv[1]) as f:
    problem = f.read()
def getrange(s):
    (start, _, end) = s[2:].partition("..")
    return (int(start), int(end))
[x, _, y] = problem[13:].partition(", ")
[x, y] = [getrange(s) for s in [x, y]]
print(x, y)

maxxy = 0
count = 0
r = 500
for xspeed, yspeed in tqdm([(xspeed, yspeed) for xspeed in range(x[1]+1) for yspeed in range(y[0]-1, abs(y[0])+1)]):
    xcur = ycur = 0
    xsc = xspeed
    ysc = yspeed
    inside = False
    maxy = 0
    while True:
        xcur += xsc
        ycur += ysc

        if xsc > 0:
            xsc -= 1
        elif xsc < 0:
            xsc += 1
        ysc -= 1

        if ycur < y[0]: break
        maxy = max(maxy, ycur)

        yinside = (y[0] <= ycur) and (ycur <= y[1])
        xinside = (x[0] <= xcur) and (xcur <= x[1])
        inside = yinside and xinside
        if inside: break

    if inside:
        count += 1
        maxxy = max(maxxy, maxy)

print(maxxy, count)