import strutils, sets

var f: File
assert open(f, "adv01.txt") == true

var line: string
var seen: HashSet[int]
while f.readLine(line):
  seen.incl(parseInt(line))
for x in seen:
  for y in seen:
    if seen.contains(2020 - x - y):
      quit($(x * y * (2020 - x - y)), 0)

echo "No such number!"
