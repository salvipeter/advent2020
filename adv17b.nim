import sets, strutils

type Point = (int, int, int, int)

func findMinMax(map: HashSet[Point]): (Point, Point) =
  var
    vmin: Point
    vmax: Point
    first = true
  for p in map:
    if first:
      first = false
      vmin = p
      vmax = p
    if vmin[0] > p[0]: vmin[0] = p[0]
    if vmax[0] < p[0]: vmax[0] = p[0]
    if vmin[1] > p[1]: vmin[1] = p[1]
    if vmax[1] < p[1]: vmax[1] = p[1]
    if vmin[2] > p[2]: vmin[2] = p[2]
    if vmax[2] < p[2]: vmax[2] = p[2]
    if vmin[3] > p[3]: vmin[3] = p[3]
    if vmax[3] < p[3]: vmax[3] = p[3]
  (vmin, vmax)

var data = "adv17.txt".readFile.split
discard data.pop                # because of the last \n

var map: HashSet[Point]
for y in 0..<data.len:
  for x in 0..<data[y].len:
    if data[y][x] == '#':
      map.incl (x, y, 0, 0)

var
  tmp: HashSet[Point]
  min_coord: Point
  max_coord: Point
for iter in 1..6:
  (min_coord, max_coord) = map.findMinMax
  for x in min_coord[0]-1..max_coord[0]+1:
    for y in min_coord[1]-1..max_coord[1]+1:
      for z in min_coord[2]-1..max_coord[2]+1:
        for w in min_coord[3]-1..max_coord[3]+1:
          var count = 0
          for dx in -1..1:
            for dy in -1..1:
              for dz in -1..1:
                for dw in -1..1:
                  if dx == 0 and dy == 0 and dz == 0 and dw == 0:
                    continue
                  if (x + dx, y + dy, z + dz, w + dw) in map:
                    count += 1
          let coord = (x, y, z, w)
          if coord in map:
            if count == 2 or count == 3:
              tmp.incl(coord)
          elif count == 3:
            tmp.incl(coord)
  swap(map, tmp)
  tmp.clear

echo map.len
