import tables

const keys = [7573546, 17786549]

func transform(subject, loop: int): int =
  result = 1
  for iter in 1..loop:
    result = (result * subject) mod 20201227

var cache: Table[int,(int,int)]
proc transform7(x, loop: int): int =
  if loop == 0:
    return x
  elif x in cache:
    let (l, y) = cache[x]
    assert l <= loop
    if l <= loop:
      result = transform7(y, loop - l)
  else:
    result = transform7((7 * x) mod 20201227, loop - 1)
  cache[x] = (loop, result)

var
  loops: array[2, int]
  loop = 1
while true:
  let x = transform7(1, loop)
  for i in 0..1:
    if x == keys[i]:
      loops[i] = loop
  if loops[0] != 0 and loops[1] != 0:
    break
  inc loop

assert transform(keys[0], loops[1]) == transform(keys[1], loops[0])
echo transform(keys[1], loops[0])
