import math, parseutils

func parseExpr(str: string): int =
  var index = 0
  proc rec(): int =
    var
      vals: seq[int]
      ops: seq[char]
      x: int
    while index < str.len:
      if str[index] == '(':
        inc index
        x = rec()
      else:
        index += str.parseInt(x, index)
      vals.add x
      if index >= str.len:
        break
      if str[index] == ')':
        inc index
        break
      inc index
      if index >= str.len:
        break
      ops.add str[index]
      index += 2
    while true:
      let i = ops.find '+'
      if i == -1:
        return vals.prod
      vals[i] += vals[i+1]
      vals.delete i + 1
      ops.delete i
  rec()

var sum = 0
for line in "adv18.txt".lines:
  sum += parseExpr(line)

echo sum
