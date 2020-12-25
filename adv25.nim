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

var loop = 1
while true:
  let x = transform7(1, loop)
  for i in 0..1:
    if x == keys[i]:
      quit($transform(keys[1-i], loop), 0)
  inc loop
