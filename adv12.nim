import strutils

func turnRight(dir: (int, int), angle: int): (int, int) =
  case angle:
    of 90: (dir[1], -dir[0])
    of 180: (-dir[0], -dir[1])
    of 270: (-dir[1], dir[0])
    else: raise newException(ValueError, "invalid angle")

func turnLeft(dir: (int, int), angle: int): (int, int) =
  turnRight(dir, 360 - angle)

var
  pos = (0, 0)
  dir = (1, 0)
for line in "adv12.txt".lines:
  let x = line[1..^1].parseInt
  case line[0]:
    of 'N':
      pos[1] += x
    of 'S':
      pos[1] -= x
    of 'E':
      pos[0] += x
    of 'W':
      pos[0] -= x
    of 'L':
      dir = dir.turnLeft(x)
    of 'R':
      dir = dir.turnRight(x)
    of 'F':
      pos[0] += dir[0] * x
      pos[1] += dir[1] * x
    else:
      quit "invalid command"

echo abs(pos[0]) + abs(pos[1])
