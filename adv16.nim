import re, sequtils, strutils

type Range = (int, int)
type Field = (string, Range, Range)
type Ticket = seq[int]

func inRange(field: Field, value: int): bool =
  let
    (min1, max1) = field[1]
    (min2, max2) = field[2]
  min1 <= value and value <= max1 or min2 <= value and value <= max2

var
  fields: seq[Field]
  nearby_tickets: seq[Ticket]
for line in "adv16.txt".lines:
  var m: array[5, string]
  if match(line, re"^(.*): (.*)-(.*) or (.*)-(.*)$", m):
    fields.add((m[0], (m[1].parseInt, m[2].parseInt), (m[3].parseInt, m[4].parseInt)))
  elif line.find(',') != -1:
    nearby_tickets.add(line.split(',').mapIt(it.parseInt))
nearby_tickets.del(0)

var scanning_rate = 0
for ticket in nearby_tickets:
  for value in ticket:
    var ok = false
    for field in fields:
      if field.inRange(value):
        ok = true
        break
    if ok == false:
      scanning_rate += value

echo scanning_rate
