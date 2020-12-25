import sequtils, strutils

func countNeighbors(data: seq[string], i, j: int, c: char): int =
  for di in -1..1:
    if i + di < 0 or i + di >= data.len:
      continue
    for dj in -1..1:
      if j + dj < 0 or j + dj >= data[i+di].len:
        continue
      if di == 0 and dj == 0:
        continue
      if data[i+di][j+dj] == c:
        inc result

var data = readFile("adv11.txt").split('\n')[0..^2]

let
  n = data.len
  m = data[0].len

var tmp = deepCopy(data)
while true:
  var changed = false
  for i in 0..<n:
    for j in 0..<m:
      let neighbors = data.countNeighbors(i, j, '#')
      if data[i][j] == 'L' and neighbors == 0:
        tmp[i][j] = '#'
        changed = true
      elif data[i][j] == '#' and neighbors >= 4:
        tmp[i][j] = 'L'
        changed = true
      else:
        tmp[i][j] = data[i][j]
  swap data, tmp
  if not changed:
    break

echo foldl(data, a + b.count('#'), 0)
