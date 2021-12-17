#!/usr/bin/env dyalogscript
input←⊃⎕NGET'inputs/13_1.txt' 1
s1 s2←((0≠(≢¨⊢))⊆⊢)input 
coords←{1+⍎¨','(≠⊆⊢)⍵}¨s1
commands←{{⍵[1],⍎⊃⍵[2]}'='(≠⊆⊢)11↓⍵}¨s2
paper←⍉⊃{b←⍵⋄b[⊂⍺]←1⋄b}/coords,⊂0⍴⍨⊃⌈/coords  
foldy←{h←(⊢⌈¯1+(⊃⍴⍵)-⊢)⍺ ⋄ ⊃∨/(h∘↑)¨((⊂⍺↑⊢),(⊂∘⊖⍺↑(⍺+1)↓⊢))⍵}
foldx←{⍉⍺ foldy ⍉⍵}
fold←{⍺[2](⍎'fold',⊃⍺)⍵}

p1←+/+/(⊃commands[1]) fold paper
⎕←'p1' p1

p2←⊃fold/(⊂paper),⍨⌽commands
pretty←{'#'@(1∘=)' '@(0∘=)⍵}
⎕←'p2' (pretty p2)


