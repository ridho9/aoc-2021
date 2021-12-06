#!/usr/bin/env dyalogscript
i←(⍎¨¨)⊃⎕NGET'inputs/3_1.txt'1
filter ← {((2÷⍨≢)⍺⍺(+⌿∘↑))⍵}
gamma←2⊥≤filter
epsilon←2⊥>filter
p1←gamma×epsilon
⎕←p1 i

maskAt←{⍺⌷⍺⍺ filter ⍵}
filterMaskedAt←{((⍺ ⍺⍺ maskAt ⍵)=(⊃(⍺-1)∘↓)¨⍵)/⍵}
contFilterTo←{2⊥¨⊃(⍺⍺ filterMaskedAt)⌿(⌽⍳⍺),⊂⍵}
width ← ⍳≢∘⊃∘⊢
advFilter←{⊃(⊢(/⍨)1=≢¨)(width(⍺⍺ contFilterTo¨)⊂)⍵}
oxy←≤advFilter
scr←>advFilter
p2←oxy×scr
⎕←p2 i