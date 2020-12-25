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
  waypoint = (10, 1)
for line in "adv12.txt".lines:
  let x = line[1..^1].parseInt
  case line[0]:
    of 'N':
      waypoint[1] += x
    of 'S':
      waypoint[1] -= x
    of 'E':
      waypoint[0] += x
    of 'W':
      waypoint[0] -= x
    of 'L':
      var dir = (waypoint[0] - pos[0], waypoint[1] - pos[1])
      dir = dir.turnLeft(x)
      waypoint = (pos[0] + dir[0], pos[1] + dir[1])
    of 'R':
      var dir = (waypoint[0] - pos[0], waypoint[1] - pos[1])
      dir = dir.turnRight(x)
      waypoint = (pos[0] + dir[0], pos[1] + dir[1])
    of 'F':
      var dir = (waypoint[0] - pos[0], waypoint[1] - pos[1])
      pos = (pos[0] + dir[0] * x, pos[1] + dir[1] * x)
      waypoint = (waypoint[0] + dir[0] * x, waypoint[1] + dir[1] * x)
    else:
      quit "invalid command"

echo abs(pos[0]) + abs(pos[1])
