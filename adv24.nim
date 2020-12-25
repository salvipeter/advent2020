import sets

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

var tiles = initHashSet[Tile]()
for line in "adv24.txt".lines:
  let tile = line.parseDirections
  if tile in tiles:
    tiles.excl tile
  else:
    tiles.incl tile

echo tiles.len
