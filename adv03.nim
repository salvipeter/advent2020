var f: File
assert open(f, "adv03.txt") == true

var map: seq[string]
var line: string
while f.readLine(line):
  map.add(line)

let
  n = map.len
  m = map[0].len
var
  x = 0
  y = 0
  tree_count = 0

while y < n:
  if map[y][x] == '#':
    inc tree_count
  x = (x + 3) mod m
  y += 1

echo tree_count
