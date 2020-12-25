import algorithm, strutils

type Tile = array[10, string]

func rotate90(tile: Tile): Tile =
  for i in 0..<tile.len:
    var str = ""
    for j in 1..tile.len:
      str.add tile[tile.len-j][i]
    result[i] = str

func rotations(tile: Tile): array[8, Tile] =
  result[0] = tile
  for i in 1..3:
    result[i] = result[i-1].rotate90
  result[4] = tile
  result[4].reverse
  for i in 5..7:
    result[i] = result[i-1].rotate90

func matchRight(t1, t2: Tile): int =
  ## Returns the rotation index (0..7) when
  ## `t2` can be placed on the right of `t1`.
  ## Returns -1 if no match found.
  let rots = t2.rotations
  for r in 0..7:
    var ok = true
    for i in 0..<t1.len:
      if t1[i][^1] != rots[r][i][0]:
        ok = false
        break
    if ok:
      return r
  return -1

func matchOther(t1, t2: Tile, rot: int): int =
  let r = t1.rotations[rot].matchRight(t2)
  if r == -1:
    return -1
  if r < 4:
    return (r + 4 - rot) mod 4
  4 + ((r - rot) mod 4)

func matchTop(t1, t2: Tile): int = matchOther(t1, t2, 1)
func matchLeft(t1, t2: Tile): int = matchOther(t1, t2, 2)
func matchBottom(t1, t2: Tile): int = matchOther(t1, t2, 3)

var
  tiles: seq[(int, Tile)]
  id, i: int
  next: Tile
for line in "adv20.txt".lines:
  if line == "":
    tiles.add (id, next)
  elif line.find("Tile") != -1:
    id = line[5..^2].parseInt
    i = 0
  else:
    next[i] = line
    inc i
tiles.add (id, next)

type Neighborhood = array[4, (int, int)] # top right bottom left (index, rotation)

var neighbors = newSeq[Neighborhood](tiles.len)
for n in neighbors.mitems:
  for i in 0..3:
    n[i][0] = -1

for i in 0..<tiles.len:
  for j in 0..<tiles.len:
    if i == j:
      continue
    let mt = tiles[i][1].matchTop(tiles[j][1])
    if mt != -1:
      neighbors[i][0] = (j, mt)
    let mr = tiles[i][1].matchRight(tiles[j][1])
    if mr != -1:
      neighbors[i][1] = (j, mr)
    let mb = tiles[i][1].matchBottom(tiles[j][1])
    if mb != -1:
      neighbors[i][2] = (j, mb)
    let ml = tiles[i][1].matchLeft(tiles[j][1])
    if ml != -1:
      neighbors[i][3] = (j, ml)

var prod = 1
for i in 0..<tiles.len:
  var count = 0
  for j in 0..3:
    if neighbors[i][j][0] == -1:
      inc count
  if count == 2:
    prod *= tiles[i][0]
echo prod
