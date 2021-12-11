#!/usr/bin/env dyalogscript
⍝ input←↑⍎¨¨⊃⎕NGET'inputs/9-4096-4.in' 1
input←↑⍎¨¨⊃⎕NGET'inputs/9_1.txt' 1
nrow ncol←⍴input
padAround←1⊖1⌽(2(ncol+2)⍴9),[1](nrow 2⍴9),input
solveRow←{
  row←⍵
  row=nrow+2:⍺
  solveCol←{
    col←⍵
    col=ncol+2:⍺
    center←padAround[row;col]
    isSmall←4=+/(center<⊢)¨{padAround[row+⍵[1];col+⍵[2]]}¨((¯1 0) (1 0) (0 ¯1) (0 1))
    (⍺+isSmall×1+center) ∇ (col+1)
  }
  (⍺+0 solveCol 2) ∇ (row+1)
}
⎕←0 solveRow 2
visited←9=input
floodFill←{
  row col←⍵
  (row=0)∨(col=0)∨(row>nrow)∨(col>ncol):0
  visited[row;col]:0
  visited[row;col]←1
  +/1,(floodFill(row col)∘+)¨(¯1 0) (1 0) (0 ¯1) (0 1)
}
find←{
  findRow←{
    row←⍵
    row>nrow:⍺
    findCol←{
      col←⍵
      col>ncol:⍺
      visited[row;col]:⍺∇col+1
      (⍺,floodFill row col)∇col+1
    }
    (⍺,⍬ findCol 1)∇row+1
  }
  ⍬ findRow 1
}
⎕←{×/3↑⍵[⍒⍵]}find 0


