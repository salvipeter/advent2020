import strutils, sets

var f: File
assert open(f, "adv01.txt") == true

var line: string
var seen: HashSet[int]
while f.readLine(line):
  let x = parseInt(line)
  if seen.contains(2020 - x):
    quit($(x * (2020 - x)), 0)
  else:
    seen.incl(x)

echo "No such number!"
