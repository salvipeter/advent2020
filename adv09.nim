import strutils

var f: File
assert open(f, "adv09.txt") == true

const n = 25                    # preamble length

func checkNumber(numbers: array[n, int], x: int): bool =
  for i in 0..<n:
    for j in 0..<n:
      if i == j:
        continue
      if numbers[i] + numbers[j] == x:
        result = true
        break

var
  i = 0
  last_n: array[n, int]
  line: string
while f.readLine(line):
  let x = parseInt(line)
  if i >= n and not last_n.checkNumber(x):
    quit $x, 0
  last_n[i mod n] = x
  inc i

echo "All numbers are OK"
