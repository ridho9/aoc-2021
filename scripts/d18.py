import sys
from math import floor, ceil
import functools

def islist(l): return isinstance(l, list)

def addl(n, l):
    if not islist(l): return n+l
    if not islist(l[0]): return [n + l[0], l[1]]
    return [addl(n, l[0]), l[1]]

def addr(n, r):
    if not islist(r): return n+r
    if not islist(r[1]): return [r[0], n+r[1]]
    return [r[0], addr(n, r[1])]

def explode(number, depth=-1):
    if depth == -1:
        res = explode(number, depth=0)
        if len(res) == 3: return res[2]
        return res
    if not islist(number): return number
    if depth == 4: return number + [0]

    lexpl = explode(number[0], depth+1)
    if islist(lexpl) and len(lexpl) == 3:
        nextr = addl(lexpl[1], number[1])
        ret =  [lexpl[0], 0, [lexpl[2], nextr]]
        return ret

    rexpl = explode(number[1], depth+1)
    if islist(rexpl) and len(rexpl) == 3:
        nextl = addr(rexpl[0], number[0])
        ret = [0, rexpl[1], [nextl, rexpl[2]]]
        return ret

    return [lexpl, rexpl]

def split(number):
    if not islist(number):
        if number < 10: return number
        return [floor(number/2), ceil(number/2)]
    lsplit = split(number[0])
    if lsplit != number[0]:
        return [lsplit, number[1]]
    return [number[0], split(number[1])]

def reduce(number):
    result = number
    while True:
        exploded = explode(result)
        if exploded != result:
            result = exploded
            continue
        splitted = split(result)
        if splitted != result:
            result = splitted
            continue
        break

    return result

def add(a, b):
    return reduce([a, b])

def addall(numbers):
    return functools.reduce(lambda x, y: add(x, y), numbers)

def magnitude(number):
    if not islist(number):
        return number
    [l, r] = [magnitude(x) for x in number]
    return 3*l + 2*r

def p1(ns):
    return magnitude(addall(ns))

def p2(ns):
    return max(magnitude(add(x, y)) for x in ns for y in ns if x != y)

with open(sys.argv[1]) as f:
    numbers = [eval(l) for l in f.readlines()]
    print("p1", p1(numbers))
    print("p2", p2(numbers))