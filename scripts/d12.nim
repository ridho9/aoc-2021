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

proc p1(): int64 =
  var queue = initDeque[(string, seq[string])]()
  var paths: int64
  for adj in graph["start"]: queue.addLast((adj, @["start"]))

  while queue.len > 0:
    var (node, history) = queue.popFirst
    if node == "end":
      paths += 1
      continue
    if node[0].isLowerAscii and node in history: continue
    history.add(node)
    for adj in graph[node]: queue.addLast((adj, history))
  result = paths

proc p2(): int64 =
  var queue = initDeque[(string, Deque[string], string, HashSet[string])]()
  var paths: HashSet[Deque[string]]
  for adj in graph["start"]: queue.addLast((adj, @["start"].toDeque, "", @["start"].toHashSet))

  while queue.len > 0:
    var (node, history, double, used) = queue.popFirst

    if node == "end": paths.incl(history)
    if node == "start" or node == "end": continue

    if node[0].isLowerAscii:
      if used.contains(node):
        if double != "": continue
        double = node
      else:
        used.incl(node)

    history.addLast(node)
    for adj in graph[node]: queue.addLast((adj, history, double, used))

  result = paths.len

echo "p1 ", p1()
echo "p2 ", p2()