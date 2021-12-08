#!/usr/bin/env dyalogscript
j←⍎⊃⊃⎕NGET'inputs/6_1.txt'1
freq←+/(0,⍳8)∘.=⊢
adv←(2⌽8 1/0,⊃)+(1∘⌽)
solve←{20 0⍕+/adv⍣⍺freq⍵}
⎕←80 solve j
⎕←256 solve j
      