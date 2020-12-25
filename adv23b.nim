const cups = [3, 6, 4, 2, 8, 9, 7, 1, 5]
const ncups = 1000000
const niter = 10000000

func decMod(i: int): int = (if i == 1: ncups else: i - 1)

var next: array[1..ncups, int]
for i in 0..<cups.len:
  if i == cups.len - 1:
    next[cups[i]] = cups.len + 1
  else:
    next[cups[i]] = cups[i+1]
for i in cups.len+1..<ncups:
  next[i] = i + 1
next[ncups] = cups[0]

var
  current = cups[0]
  taken: array[3, int]
for iter in 1..niter:
  taken[0] = next[current]
  taken[1] = next[taken[0]]
  taken[2] = next[taken[1]]
  var dest = current.decMod
  while dest in taken:
    dest = dest.decMod
  next[current] = next[taken[2]]
  next[taken[2]] = next[dest]
  next[dest] = taken[0]
  current = next[current]

let
  star1 = next[1]
  star2 = next[star1]
echo star1 * star2
