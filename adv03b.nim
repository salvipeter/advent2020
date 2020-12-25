var f: File
assert open(f, "adv03.txt") == true

var map: seq[string]
var line: string
while f.readLine(line):
  map.add(line)

let
  n = map.len
  m = map[0].len
  dirs = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
var multiplied = 1

for dir in dirs:
  var
    x = 0
    y = 0
    tree_count = 0
  while y < n:
    if map[y][x] == '#':
      inc tree_count
    x = (x + dir[0]) mod m
    y = y + dir[1]
  multiplied *= tree_count

echo multiplied
