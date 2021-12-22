import functools
def p1(p1_start, p2_start):
    dicesum = [3, 6, 9, 2, 5, 8, 1, 4, 7, 0]
    def triplesum(dice):
        return dicesum[dice%10]

    def advdice(dice):
        dice += 3
        if dice > 100:
            dice -= 100
        return dice

    p1_start -= 1
    p2_start -= 1
    p1_score = p2_score = rollcount = lose_score = 0

    dice = 1

    while True:
        p1_start = (p1_start + triplesum(dice)) % 10
        p1_score += p1_start + 1
        rollcount += 3
        dice = advdice(dice)
        if p1_score >= 1000:
            lose_score = p2_score
            break
        
        p2_start = (p2_start + triplesum(dice)) % 10
        p2_score += p2_start + 1
        dice = advdice(dice)
        rollcount += 3
        if p2_score >= 1000:
            lose_score = p1_score
            break

    return rollcount*lose_score

dirac_dice = [a+b+c for a in range(1, 4) for b in range(1, 4) for c in range(1, 4)]
print(dirac_dice)

def advpos(pos, adv):
    pos += adv
    if pos > 10:
        pos -= 10
    return pos

limit = 100

@functools.cache
def dirac(p1_pos, p2_pos, p1_score, p2_score, turn):
    if p1_score >= limit:
        return 1, 0
    if p2_score >= limit:
        return 0, 1

    tp1_win = tp2_win = 0
    for psb in dirac_dice:
        if turn == 1:
            cpos = advpos(p1_pos, psb)
            p1_win, p2_win = dirac(cpos, p2_pos, p1_score + cpos, p2_score, 2)
        else:
            cpos = advpos(p2_pos, psb)
            p1_win, p2_win = dirac(p1_pos, cpos, p1_score, p2_score + cpos, 1)
        tp1_win += p1_win
        tp2_win += p2_win

    return tp1_win, tp2_win

p1_start = 4
p2_start = 8
print(f"p1 {p1(p1_start, p2_start)=}")
print(f"p2 {max(dirac(p1_start, p2_start, 0, 0, 1))=}")