#!/usr/bin/env dyalogscript
i←⊃⎕nget'inputs/2_1'1
parse←((⊃⊃),(⍎∘⊃(2⌷⊢)))¨' '(≠⊆⊢)¨⊢
s1←{
  (c x)←⍵
  c='f':x,0
  c='d':0,x
  0,-x
}
p1←{×⌿+⌿↑s1¨parse⍵}
⎕←p1 i