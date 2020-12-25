import algorithm

type Tile = array[96, string]

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

proc markSeaMonsters(image: var Tile) =
  const monster = ["                  # ",
                   "#    ##    ##    ###",
                   " #  #  #  #  #  #   "]
  const width = monster[0].len
  const height = monster.len
  for x in 0..<image.len-width:
    for y in 0..<image[x].len-height:
      var found = true
      for j in 0..<height:
        for i in 0..<width:
          if monster[j][i] == '#':
            if image[x+i][y+j] != '#':
              found = false
              break
      if found:
        for j in 0..<height:
          for i in 0..<width:
            if monster[j][i] == '#':
              image[x+i][y+j] = 'O'

func computeRoughness(image: Tile): int =
  var t = image
  t.markSeaMonsters
  for i in 0..<image.len:
    for j in 0..<image[i].len:
      if t[i][j] == '#':
        inc result

var
  i = 0
  image: Tile
for line in "adv20b.txt".lines:
  image[i] = line
  inc i

var roughness = 0
for t in image.rotations:
  let r = t.computeRoughness
  if roughness == 0:
    roughness = r
  elif r < roughness:
    roughness = r

echo roughness
