#!/usr/bin/env dyalogscript
i←(⍎¨¨)⊃⎕NGET'inputs/3_1.txt'1

filter ← {((2÷⍨≢)⍺⍺(+⌿∘↑))⍵}
p1←×/2∘⊥¨∘(~,⊢)∘((2÷⍨≢)≤+/)
⎕←p1 i

maskAt←{⍺⌷⍺⍺ filter ⍵}
filterMaskedAt←{((⍺ ⍺⍺ maskAt ⍵)=(⊃(⍺-1)∘↓)¨⍵)/⍵}
contFilterTo←{2⊥¨⊃(⍺⍺ filterMaskedAt)⌿(⌽⍳⍺),⊂⍵}
width ← ⍳≢∘⊃∘⊢
filterSingle ← ⊢(/⍨)1=≢¨
advFilter←{⊃filterSingle(width(⍺⍺ contFilterTo¨)⊂)⍵}
oxy←≤advFilter
scr←>advFilter
p2←oxy×scr
⎕←p2 i