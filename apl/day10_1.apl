#!/usr/bin/env dyalogscript
input←⊃⎕nget'inputs/10_2.txt'1
left right←('({[<') (')}]>')
rec←{
  ⍺←⍬
  cur next←(⊃⍵) (1↓⍵)
  0=⍴⍵:⍺
  ⍬≡⍺:cur ∇ next
  cur∊left:(cur,⍺) ∇ next
  (⊃⍺)≡(left⌷⍨right⍳⊢)cur:(1↓⍺) ∇ next
  cur
}
proc←(rec)¨input
take←(1=≢)¨proc
p1←+/(3 1197 57 25137 0⌷⍨right⍳⊢)¨proc/⍨take
⎕←'p1' p1

scores←{{⍺+5×⍵}/⌽0,(1 3 2 4 0⌷⍨left⍳⊢)¨⍵}¨proc/⍨~take
count←+/~take
p2←(⌈2÷⍨count)⌷scores[⍋scores]
⎕←'p2' p2


