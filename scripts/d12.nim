import os, std/[sequtils, strutils, sets, tables, deques]
# import nimprof

let input = lines(paramStr(1)).toSeq.map(proc (l:string): seq[string] = l.split('-'))
var graph: Table[string, HashSet[string]]
for pair in input:
  let (a, b) = (pair[0], pair[1])
  discard graph.hasKeyOrPut(a, initHashSet[string]())
  discard graph.hasKeyOrPut(b, initHashSet[string]())
  graph[a].incl(b)
  graph[b].incl(a)

proc solve(d: bool): int64 =
  var queue = initDeque[(string, HashSet[string], bool)]()
  var paths: int
  for adj in graph["start"]: queue.addLast((adj, @["start"].toHashSet, d))
  # var memo: HashSet[(string, HashSet[string], bool)]

  while queue.len > 0:
    var (node, history, canDouble) = queue.popFirst

    # if memo.containsOrIncl((node, history, canDouble)):
    #   echo "can memo ", node, " ", history, " ", canDouble

    # if node == "end": paths.add(history)
    if node == "end": paths += 1
    if node == "start" or node == "end": continue

    if node[0].isLowerAscii:
      if node in history:
        if canDouble == false: continue
        canDouble = false

    history.incl(node)
    for adj in graph[node]:
      if adj == "start" : continue
      queue.addLast((adj, history, canDouble))

  result = paths

echo "p1 ", solve(false)
echo "p2 ", solve(true)