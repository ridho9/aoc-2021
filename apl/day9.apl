#!/usr/bin/env dyalogscript
⍝ input←↑⍎¨¨⊃⎕NGET'inputs/9-4096-4.in' 1
input←↑⍎¨¨⊃⎕NGET'inputs/9_1.txt' 1

isCenterSmall←{∧/(⍵[2;2]<⊢)¨(9⍴0 1)/⊃,/↓⍵}
padAround←{⍉1⌽(((2+2⌷⍴⍵),2)⍴9),⍉1⌽(((1⌷⍴⍵),2)⍴9),⍵}input
lowMask←(isCenterSmall⌺3 3)padAround
p1←(+/+/lowMask)+(+/+/padAround×lowMask)
⎕←p1

nrow ncol←⍴input
visited←9=input
floodFill←{
  row col←⍵
  (row=0)∨(col=0)∨(row>nrow)∨(col>ncol):0
  visited[row;col]:0
  visited[row;col]←1
  +/1,(floodFill(row col)∘+)¨(¯1 0) (1 0) (0 ¯1) (0 1)
}
run←{
  pointsLeft←⍸~visited
  0=≢pointsLeft:0
  p←⊃pointsLeft
  fill←floodFill p
  fill,run 0
}
basins←run 0
⎕←×/3↑basins[⍒basins]


