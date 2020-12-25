import algorithm, strutils

var cache: seq[(bool,int)]

proc computeVariations(data: seq[int], joltage, start: int): int =
  if start == data.len:
    return 1
  for i in start..<data.len:
    if data[i] <= joltage:
      continue
    if data[i] - joltage > 3:
      break
    if not cache[i][0]:
      cache[i] = (true, data.computeVariations(data[i], i + 1))
    result += cache[i][1]

var data: seq[int]
for line in "adv10.txt".lines:
  data.add(line.parseInt)

data.sort()

cache = newSeq[(bool,int)](data.len)
echo data.computeVariations(0, 0)
