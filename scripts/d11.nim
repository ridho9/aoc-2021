import os, std/[sequtils]
import nimprof

var input: seq[int]
var nrow, ncol = 0
for line in lines(paramStr(1)):
  nrow += 1
  if ncol == 0: ncol = len(line)
  for c in line: input.add(ord(c)-48)
let area = nrow*ncol
  
var 
  visited = newSeq[bool](area)
  queued = newSeq[bool](area)
  checkQueue = newSeq[int](area)
  result: int
  checkIndex: int
  (total, iteration) = (0, 1)
let range = toSeq(0..<area)

proc pushCheck(num: int) =
  checkQueue[checkIndex] = num
  checkIndex += 1
  queued[num] = true

proc popCheck(): int =
  checkIndex -= 1
  result = checkQueue[checkIndex]
  queued[result] = false

while true:
  result = 0
  for p in range:
      input[p] += 1
      visited[p] = false
      if input[p] > 9: pushCheck(p)
  while checkIndex > 0:
    let p = popCheck()
    if visited[p]: continue
    visited[p] = true
    result += 1
    input[p] = 0
    let c = p mod nrow
    let r = p div nrow
    for rr in r-1..r+1:
      for cc in c-1..c+1:
        if (cc < 0) or (cc >= ncol) or (rr < 0) or (rr >= nrow): continue
        let pp = rr*nrow + cc
        if (p == pp) or visited[pp] or queued[pp]: continue
        input[pp] += 1
        if input[pp] > 9: pushCheck(pp)

  total += result
  if iteration == 100: echo "p1 ", total
  if result == area:
    echo "p2 ", iteration
    break
  iteration += 1
