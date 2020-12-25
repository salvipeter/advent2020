import algorithm, bitops, strutils, tables

func applyMask(mask: seq[char], value: int): int =
  result = value
  let all_one = 1 shl mask.len - 1
  var exp = 1
  for i in 0..<mask.len:
    if mask[i] == '0':
      result = bitand(result, all_one - exp)
    elif mask[i] == '1':
      result = bitor(result, exp)
    exp *= 2

var
  mask: seq[char]
  memory: Table[int,int]
for line in "adv14.txt".lines:
  if line[0..3] == "mask":
    mask = line[7..^1].reversed
  else:
    let
      index_end = line.find(']')
      index = line[4..<index_end].parseInt
      value = line[index_end+4..^1].parseInt
      masked = applyMask(mask, value)
    if masked == 0:
      memory.del(index)
    else:
      memory[index] = masked

var sum = 0
for v in memory.values:
  sum += v
echo sum
