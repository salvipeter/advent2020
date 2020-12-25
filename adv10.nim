import algorithm, strutils

var f: File
assert open(f, "adv10.txt") == true

var
  data: seq[int]
  line: string
while f.readLine(line):
  data.add(line.parseInt)

data.sort()

var
  joltage = 0
  ones = 0
  threes = 0
for x in data:
  if x - joltage == 1:
    inc ones
  elif x - joltage == 3:
    inc threes
  elif x - joltage > 3:
    quit "Invalid input"
  joltage = x

echo ones * (threes + 1)
