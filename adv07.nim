import sequtils, strutils, tables

var f: File
assert open(f, "adv07.txt") == true

type BagRules = Table[string, seq[(string, int)]]

func insertable(rules: BagRules, bag: string, color: string): bool =
  anyIt(rules[bag], it[0] == color) or anyIt(rules[bag], rules.insertable(it[0], color))

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

var eligible_count = 0
for (c, si) in map.pairs:
  if map.insertable(c, "shiny gold"):
    inc eligible_count

echo eligible_count
