import sys
with open(sys.argv[1]) as f:
    problem = f.read()
def getrange(s):
    (start, _, end) = s[2:].partition("..")
    return (int(start), int(end))
[x, _, y] = problem[13:].partition(", ")
[x, y] = [getrange(s) for s in [x, y]]
print(x, y)

# find y
xspeed, yspeed = 0, 0
while True:
    xcur, ycur = 0, 0
    maxx, maxy = -1, -1
    xsc, ysc = xspeed, yspeed
    intersect = False
    # simulate
    while True:
        print(f"{xcur=} {ycur=} {xsc=} {ysc=}")
        # emulate shot
        xcur += xsc
        ycur += ysc
        if xsc > 0:
            xsc -= 1
        elif xsc < 0:
            xsc += 1
        ysc -= 1

        if (ycur > maxy):
            maxy = ycur

        yinside = (y[0] <= ycur) and (ycur <= y[1])
        print(f"{yinside=}")
        if yinside: 
            intersect = True
            break
        if ycur < y[0]: break
        # input()

    if intersect:
        yspeed += 1
    else:
        # found yspeed that passes y area, take the point before
        maxy -= yspeed
        yspeed -= 1
        break

print("found yspeed", xspeed, yspeed, maxy)
xspeed = x[1] + 1

# while True:
#     xcur, ycur = 0, 0
#     xsc, ysc = xspeed, yspeed
#     intersect = False
#     # simulate
#     while True:
#         print(f"{xcur=} {ycur=} {xsc=} {ysc=}")
#         # emulate shot
#         xcur += xsc
#         ycur += ysc
#         if xsc > 0:
#             xsc -= 1
#         elif xsc < 0:
#             xsc += 1
#         ysc -= 1

#         xinside = (x[0] <= xcur) and (xcur <= x[1])
#         print(f"{xinside=}")
#         if xinside: 
#             intersect = True
#             break
#         if xcur < x[0]: break
#         if xsc == 0: break
#         # input()

#     if intersect:
#         xspeed -= 1
#     else:
#         # found yspeed that passes y area, take the point before
#         xspeed += 1
#         break

# print("found xspeed", xspeed, yspeed)