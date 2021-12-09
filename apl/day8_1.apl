#!/usr/bin/env dyalogscript
input←⊃⎕nget'inputs/8_1.txt' 1
sider←{' '(≠⊆⊢)⊃⍺⌷⍵⊆⍨'|'≠⍵}
left←1∘sider
right←2∘sider
p1←+/ ((+/+/)2 4 3 7∘.=≢¨∘right)¨
⎕←p1 input

numList←{
  line←⍵
  sorted←line[⍋≢¨line]
  num1 num4 num7 num8←sorted[1 3 2 10]

  segADG←⊃∩/sorted[4 5 6]
  segABFG←⊃∩/sorted[7 8 9]
  segAG←segADG∩segABFG
  segC←num1~segABFG∩num1
  segE←segAG~⍨num4~⍨num8

  num2←segADG∪segC∪segE
  num3←segADG∪num1
  num5←segADG∪segABFG
  num6←segABFG∪num5∪segE
  num9←segADG∪num4
  num0←num8~segADG~segAG

  (⍎'num',⍕)¨0,⍳9
}
sort←⊂∘⍋⌷⊢
solveLine ← 10⊥¯1+(sort¨numList∘left)⍳(sort¨right)
p2 ← +/solveLine¨
⎕←p2 input