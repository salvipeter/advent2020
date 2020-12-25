import sequtils, strutils, tables

var f: File
assert open(f, "adv07.txt") == true

type BagRules = Table[string, seq[(string, int)]]

func bagsIn(rules: BagRules, bag: string): int =
  foldl(rules[bag], a + b[1] * (rules.bagsIn(b[0]) + 1), 0)

var map: BagRules

var line: string
while f.readLine(line):
  let
    i = line.find(" bag")
    color = line[0..<i]
  map[color] = @[]
  var next = i + 14
  while next < line.len:
    if line[next..next+1] == "no":
      break
    let
      space = line.find(' ', next)
      bag = line.find(" bag", space)
    map[color].add((line[space+1..<bag], parseInt(line[next..<space])))
    next = line.find({ ',', '.' }, bag) + 2

echo map.bagsIn("shiny gold")
