import strutils

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

while p1.len > 0 and p2.len > 0:
  if p1[0] > p2[0]:
    p1.add p1[0]
    p1.add p2[0]
  else:
    p2.add p2[0]
    p2.add p1[0]
  p1.delete 0
  p2.delete 0

let p = if p1.len == 0: p2 else: p1

var
  score = 0
  m = p.len
for i in 0..<p.len:
  score += p[i] * m
  dec m

echo score
