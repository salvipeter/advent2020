import parseutils

func parseExpr(str: string): int =
  var index = 0
  proc rec(): int =
    var
      op = '+'
      x: int
    while index < str.len:
      if str[index] == '(':
        inc index
        x = rec()
      else:
        index += str.parseInt(x, index)
      if op == '+':
        result += x
      else:
        result *= x
      if index >= str.len:
        break
      if str[index] == ')':
        inc index
        break
      inc index
      if index >= str.len:
        break
      op = str[index]
      index += 2
  rec()

var sum = 0
for line in "adv18.txt".lines:
  sum += parseExpr(line)

echo sum
