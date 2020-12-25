import sets, strutils

# Nicer solution for arbitrary dimensions

const dim = 4
type Point = array[dim, int]

func findMinMax(map: HashSet[Point]): (Point, Point) =
  var
    vmin, vmax: Point
    first = true
  for p in map:
    if first:
      first = false
      vmin = p
      vmax = p
      continue
    for i in 0..<dim:
      if vmin[i] > p[i]:
        vmin[i] = p[i]
      if vmax[i] < p[i]:
        vmax[i] = p[i]
  (vmin, vmax)

func countNeighbors(map: HashSet[Point], p: Point): int =
  var
    d: Point
    count = 0
  proc rec(i: int) =
    if i == dim:
      var
        center = true
        q: Point
      for j in 0..<dim:
        if d[j] != 0:
          center = false
        q[j] = p[j] + d[j]
      if not center and q in map:
        inc count
    else:
      for di in -1..1:
        d[i] = di
        rec(i + 1)
  rec(0)
  count

func doIteration(map: HashSet[Point]): HashSet[Point] =
  let (pmin, pmax) = map.findMinMax
  var
    tmp: HashSet[Point]
    p: Point
  proc rec(i: int) =
    if i == dim:
      let count = map.countNeighbors(p)
      if p in map:
        if count == 2 or count == 3:
          tmp.incl(p)
      elif count == 3:
        tmp.incl(p)
    else:
      for pi in pmin[i]-1..pmax[i]+1:
        p[i] = pi
        rec(i + 1)
  rec(0)
  tmp

var data = "adv17.txt".readFile.split
discard data.pop                # because of the last \n

var map: HashSet[Point]
for y in 0..<data.len:
  for x in 0..<data[y].len:
    if data[y][x] == '#':
      var p: Point
      p[0] = x
      p[1] = y
      map.incl(p)

for iter in 1..6:
  map = map.doIteration

echo map.len
