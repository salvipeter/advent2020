import sets, strutils

func score(p: seq[int]): int =
  var m = p.len
  for i in 0..<p.len:
    result += p[i] * m
    dec m

func game(p1, p2: seq[int]): (int, int) =
  var
    seen = initHashSet[(int,int)]()
    p1 = p1
    p2 = p2
  while true:
    let id = (p1.score, p2.score)
    if id in seen or p2.len == 0:
      return (0, id[0])                # Player 1 wins
    if p1.len == 0:
      return (1, id[1])
    seen.incl id
    var winner: int
    if p1[0] < p1.len and p2[0] < p2.len:
      var tmp: int
      (winner, tmp) = game(p1[1..p1[0]], p2[1..p2[0]])
    elif p1[0] > p2[0]:
      winner = 0
    else:
      winner = 1
    if winner == 0:
      p1.add p1[0]
      p1.add p2[0]
    else:
      p2.add p2[0]
      p2.add p1[0]
    p1.delete 0
    p2.delete 0

var
  player1 = true
  p1, p2: seq[int]
for line in "adv22.txt".lines:
  if line.find("Player") != -1:
    continue
  if line == "":
    player1 = false
    continue
  if player1:
    p1.add line.parseInt
  else:
    p2.add line.parseInt

echo game(p1, p2)[1]
