import sequtils, strutils

func countNeighbors(data: seq[string], i, j: int): int =
  for (di, dj) in [(-1,-1), (0,-1), (1,-1), (-1,0), (1,0), (-1,1), (0,1), (1,1)]:
    var
      i1 = i
      j1 = j
    while true:
      i1 += di
      j1 += dj
      if i1 < 0 or i1 >= data.len or j1 < 0 or j1 >= data[i1].len:
        break
      if data[i1][j1] == '#':
        inc result
        break
      elif data[i1][j1] == 'L':
        break

var data = readFile("adv11.txt").split('\n')[0..^2]

let
  n = data.len
  m = data[0].len

var tmp = deepCopy(data)
while true:
  var changed = false
  for i in 0..<n:
    for j in 0..<m:
      let neighbors = data.countNeighbors(i, j)
      if data[i][j] == 'L' and neighbors == 0:
        tmp[i][j] = '#'
        changed = true
      elif data[i][j] == '#' and neighbors >= 5:
        tmp[i][j] = 'L'
        changed = true
      else:
        tmp[i][j] = data[i][j]
  swap data, tmp
  if not changed:
    break

echo foldl(data, a + b.count('#'), 0)
