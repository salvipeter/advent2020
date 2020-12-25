import tables

const goal = 2020

const numbers = [10, 16, 6, 0, 1, 17]

type Memory = Table[int,int]

var
  turn = 0
  mem: Memory
while turn < numbers.len:
  mem[numbers[turn]] = turn
  inc turn

var
  last = numbers[^1]
  next = 0
while turn < goal:
  last = next
  if next in mem:
    next = turn - mem[next]
  else:
    next = 0
  mem[last] = turn
  inc turn

echo last
