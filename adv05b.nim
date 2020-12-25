import strutils, sets

var f: File
assert open(f, "adv05.txt") == true

func computeID(seat: string): int =
  let
    row = seat[0..<7].replace('F', '0').replace('B', '1').parseBinInt()
    col = seat[7..^1].replace('L', '0').replace('R', '1').parseBinInt()
  row * 8 + col

var
  seen: HashSet[int]
  line: string
while f.readLine(line):
  let id = computeID(line)
  seen.incl(id)

for id in 1..<1023:
  if seen.contains(id-1) and not seen.contains(id) and seen.contains(id+1):
    echo id
    break
