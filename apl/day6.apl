#!/usr/bin/env dyalogscript
j←⍎⊃⊃⎕NGET'inputs/6_1.txt'1
idm←↓∘.=⍨⍳9
mask←⊃idm⌷⍨1+⊢
freq←+⌿∘↑mask¨
adv←{((⊃⍵)×mask 6)+(⊃⍵),⍨1↓⍵}
solve←{20 0⍕+/adv⍣⍺freq⍵}
⎕←80 solve j
⎕←256 solve j
      