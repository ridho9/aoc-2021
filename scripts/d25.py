import sys
with open(sys.argv[1]) as f:
    field = [s.strip() for s in f.readlines()]
nrow, ncol = len(field), len(field[0])

fdict = {'.': '.', '>': 'v', 'v': '>'}

def transpose(field):
    tpsd = list(''.join(fdict[c] for c in list(z)) for z in zip(*[list(l) for l in field]))
    return tpsd

def step_east(field):
    nc = len(field[0])
    res = []
    for l in field:
        line = (l*3).replace(">.", ".>")
        res.append(line[nc:2*nc])
    return res

def step(field):
    # east move
    field = step_east(field)
    field = transpose(field)
    field = step_east(field)
    field = transpose(field)

    return field

def iterate(field):
    it = 0
    while True:
        new_field = step(field)
        it += 1
        if field == new_field:
            break
        field = new_field
    return it

print(iterate(field))