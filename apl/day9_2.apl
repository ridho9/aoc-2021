#!/usr/bin/env dyalogscript
input←↑⍎¨¨⊃⎕NGET'inputs/9-4096-4.in'1
⍝ input←↑⍎¨¨⊃⎕NGET'inputs/9_1.txt' 1
nrow ncol←⍴input
padInput←1⊖1⌽(2(ncol+2)⍴9),[1](nrow 2⍴9),input
adj←(¯1 0) (1 0) (0 ¯1) (0 1)
solveRow←{
  ⍵=nrow+2:⍺
  solveCol←{
    ⍵[2]=ncol+2:⍺
    center←1+⍵⌷padInput
    isSmall←4=+/(center≤padInput⌷⍨⍵+⊢)¨adj
    (⍺+isSmall×center) ∇ ⍵+0 1
  }
  (⍺+0 solveCol ⍵ 2) ∇ ⍵+1
}
⎕←0 solveRow 2

visited←9=padInput
floodFill←{
  visited⌷⍨⍵:0
  visited[⊂⍵]←1
  +/1,(floodFill⍵+⊢)¨adj
}
find←{
  findRow←{
    ⍵=nrow+2:⍺
    findCol←{
      ⍵[2]=ncol+2:⍺
      visited⌷⍨⍵:⍺ ∇ ⍵+0 1
      (⍺,floodFill ⍵) ∇ ⍵+0 1
    }
    (⍺,⍬ findCol ⍵ 2) ∇ ⍵+1
  }
  ⍬ findRow 2
}
⎕←{×/3↑⍵[⍒⍵]}find 0


