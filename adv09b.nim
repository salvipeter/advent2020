import strutils

var f: File
assert open(f, "adv09.txt") == true

const goal = 1038347917

type Sum = tuple
  smallest, largest, sum: int

var
  data: seq[Sum]
  line: string
while f.readLine(line):
  let x = parseInt(line)
  for i in 0..<data.len:
    if data[i].sum < goal:
      data[i].sum += x
      if x < data[i].smallest:
        data[i].smallest = x
      if x > data[i].largest:
        data[i].largest = x
      if data[i].sum == goal:
        quit $(data[i].smallest + data[i].largest), 0
  data.add((x, x, x))

