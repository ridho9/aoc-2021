#!/usr/bin/env dyalogscript
input←⊃⎕nget'inputs/20_1.txt'1
mapping←1@('#'=⊢)0@('.'=⊢)⊃input
grid←↑{1@('#'=⊢)0@('.'=⊢)⍵}¨2↓input
width←⊃⍴grid
pad←{
    grid←⍵
    factor←⍺
    exp←factor×width
    (width×⌈factor÷2)⌽[2](width×⌈factor÷2)⌽[1]exp↑[2]exp↑[1]grid
}
iter←({mapping⌷⍨1+2⊥⊃,/↓⍵}⌺(3 3))
runiter←{(-⍺)↓[2] (-⍺)↓[1] (⌈⍺÷2)⌽[2] (⌈⍺÷2)⌽[1] (iter⍣⍺) (20) pad ⍵}
p1←+/+/ (2 runiter grid)
⎕←'p1' p1
p2←+/+/ (50 runiter grid)
⎕←'p2' p2