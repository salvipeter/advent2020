import algorithm, strutils

type Tile = array[10, string]

const filename = "adv20.txt"
const size = (12, 12)

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

func addRotation(r, rot: int): int =
  if r == -1:
    return -1
  [[0,1,2,3,4,5,6,7],
   [1,2,3,0,7,4,5,6],
   [2,3,0,1,6,7,4,5],
   [3,0,1,2,5,6,7,4],
   [4,5,6,7,0,1,2,3],
   [5,6,7,4,3,0,1,2],
   [6,7,4,5,2,3,0,1],
   [7,4,5,6,1,2,3,0]][r][rot]

func matchOther(t1, t2: Tile, rot: int): int =
  t1.rotations[rot].matchRight(t2).addRotation(4 - rot)

func matchTop(t1, t2: Tile): int = matchOther(t1, t2, 1)
func matchLeft(t1, t2: Tile): int = matchOther(t1, t2, 2)
func matchBottom(t1, t2: Tile): int = matchOther(t1, t2, 3)

var
  tiles: seq[(int, Tile)]
  id, i: int
  next: Tile
for line in filename.lines:
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
      assert neighbors[i][0][0] == -1
      neighbors[i][0] = (j, mt)
    let mr = tiles[i][1].matchRight(tiles[j][1])
    if mr != -1:
      assert neighbors[i][1][0] == -1
      neighbors[i][1] = (j, mr)
    let mb = tiles[i][1].matchBottom(tiles[j][1])
    if mb != -1:
      assert neighbors[i][2][0] == -1
      neighbors[i][2] = (j, mb)
    let ml = tiles[i][1].matchLeft(tiles[j][1])
    if ml != -1:
      assert neighbors[i][3][0] == -1
      neighbors[i][3] = (j, ml)

var image: array[size[0], array[size[1], (int, int)]]
for i in 0..<image.len:
  for j in 0..<image[i].len:
    image[i][j][0] = -1

proc fillImage(x, y, i, rot: int) =
  if x < 0 or x >= size[0] or y < 0 or y >= size[1] or i == -1 or image[y][x][0] != -1:
    return
  image[y][x] = (i, rot)
  let current = tiles[i][1].rotations[rot]
  var n = [(-1,0),(-1,0),(-1,0),(-1,0)]
  for j in 0..3:
    let neighbor = neighbors[i][j][0]
    if neighbor == -1:
      continue
    let t = tiles[neighbor][1]
    let mt = current.matchTop(t)
    if mt != -1:
      n[0] = (neighbor, mt)
    let mr = current.matchRight(t)
    if mr != -1:
      n[1] = (neighbor, mr)
    let mb = current.matchBottom(t)
    if mb != -1:
      n[2] = (neighbor, mb)
    let ml = current.matchLeft(t)
    if ml != -1:
      n[3] = (neighbor, ml)
  fillImage(x, y - 1, n[0][0], n[0][1])
  fillImage(x + 1, y, n[1][0], n[1][1])
  fillImage(x, y + 1, n[2][0], n[2][1])
  fillImage(x - 1, y, n[3][0], n[3][1])

# Find a corner
var
  x, y, start: int
for i in 0..<tiles.len:
  var count = 0
  for j in 0..3:
    if neighbors[i][j][0] == -1:
      inc count
  if count == 2:
    start = i
    if neighbors[i][0][0] == -1 and neighbors[i][1][0] == -1:
      x = size[0] - 1
      y = 0
      break
    if neighbors[i][1][0] == -1 and neighbors[i][2][0] == -1:
      x = size[0] - 1
      y = size[1] - 1
      break
    if neighbors[i][2][0] == -1 and neighbors[i][3][0] == -1:
      x = 0
      y = size[1] - 1
      break
    if neighbors[i][3][0] == -1 and neighbors[i][0][0] == -1:
      x = 0
      y = 0
      break

fillImage(x, y, start, 0)

for i in 0..<image.len:
  for row in 1..8:
    var str = ""
    for j in 0..<image[i].len:
      let t = tiles[image[i][j][0]][1].rotations[image[i][j][1]]
      str.add t[row][1..^2]
    echo str

# for i in 0..<image.len:
#   for row in 0..9:
#     var str = ""
#     for j in 0..<image[i].len:
#       if image[i][j][0] == -1:
#         str.add "xxxxxxxxxx"
#       else:
#         let t = tiles[image[i][j][0]][1].rotations[image[i][j][1]]
#         str.add t[row]
#       str.add ' '
#     echo str
#   echo ""
