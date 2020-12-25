import strutils

var f: File
assert open(f, "adv05.txt") == true

func computeID(seat: string): int =
  let
    row = seat[0..<7].replace('F', '0').replace('B', '1').parseBinInt()
    col = seat[7..^1].replace('L', '0').replace('R', '1').parseBinInt()
  row * 8 + col

var
  max_id = 0
  line: string
while f.readLine(line):
  let id = computeID(line)
  if id > max_id:
    max_id = id

echo max_id
