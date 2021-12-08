#!/usr/bin/env dyalogscript
i←⍎⊃⊃⎕NGET'inputs/7_1.txt'1
idxg←0,(⍳⌈/)
sort←{⍺[2]<⍵[2]:⍺⋄⍵}
p1←{sort/↓⍉(idxg ⍵),[0.5]+/(idxg ⍵)∘.(|-)⍵}
tr←{2÷⍨⍵×⍵+1}
p2←{sort/↓⍉(idxg ⍵),[0.5]+/tr¨(idxg ⍵)∘.(|-)⍵}
⎕←p1 i
⎕←p2 i


