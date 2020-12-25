import sequtils, sets

type Tile = (int, int)

func parseDirections(str: string): Tile =
  var
    x = 0
    y = 0
    i = 0
  while i < str.len:
    if str[i] == 'e':
      inc x
    elif str[i] == 's':
      inc y
      inc i
      if str[i] == 'e':
        inc x
    elif str[i] == 'w':
      dec x
    elif str[i] == 'n':
      dec y
      inc i
      if str[i] == 'w':
        dec x
    inc i
  (x, y)

func adjacent(tiles: HashSet[Tile], tile: Tile): seq[Tile] =
  const neighbors = [(1,0), (1,1), (0,1), (-1,0), (-1,-1), (0,-1)]
  neighbors.mapIt((tile[0] + it[0], tile[1] + it[1]))

func flipTiles(tiles: HashSet[Tile]): HashSet[Tile] =
  result = initHashSet[Tile]()
  for tile in tiles:
    let
      neighbors = tiles.adjacent(tile)
      count = neighbors.countIt(it in tiles)
    if count == 1 or count == 2:
      result.incl tile
    for n in neighbors:
      if not (n in tiles):
        if tiles.adjacent(n).countIt(it in tiles) == 2:
          result.incl n

var tiles = initHashSet[Tile]()
for line in "adv24.txt".lines:
  let tile = line.parseDirections
  if tile in tiles:
    tiles.excl tile
  else:
    tiles.incl tile

for iter in 1..100:
  tiles = tiles.flipTiles

echo tiles.len
