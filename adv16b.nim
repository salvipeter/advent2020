import re, sequtils, sets, strutils

type Range = (int, int)
type Field = (string, Range, Range)
type Ticket = seq[int]

func inRange(field: Field, value: int): bool =
  let
    (min1, max1) = field[1]
    (min2, max2) = field[2]
  min1 <= value and value <= max1 or min2 <= value and value <= max2

func check(ticket: Ticket, fields: seq[Field]): bool =
  for value in ticket:
    var ok = false
    for field in fields:
      if field.inRange(value):
        ok = true
        break
    if ok == false:
      return false
  true

var
  fields: seq[Field]
  nearby_tickets: seq[Ticket]
for line in "adv16.txt".lines:
  var m: array[5, string]
  if match(line, re"^(.*): (.*)-(.*) or (.*)-(.*)$", m):
    fields.add((m[0], (m[1].parseInt, m[2].parseInt), (m[3].parseInt, m[4].parseInt)))
  elif line.find(',') != -1:
    nearby_tickets.add(line.split(',').mapIt(it.parseInt))
let my_ticket = nearby_tickets[0]
nearby_tickets.del(0)

# Finds all valid positions for every field
var positions = newSeq[HashSet[int]](fields.len)
for (k, ticket) in nearby_tickets.pairs:
  if ticket.check(fields):
    for j in 0..<fields.len:
      var valid: HashSet[int]
      for i in 0..<ticket.len:
        if fields[j].inRange(ticket[i]):
          valid.incl(i)
      if positions[j].len == 0: # assumes that there is a solution
        positions[j] = valid
      else:
        positions[j] = intersection(positions[j], valid)

# Removes value from all positions, except at index, where it will be the sole value
proc purge(index: int, value: int) =
  positions[index].clear()
  positions[index].incl(value)
  for k in 0..<fields.len:
    if k != index:
      positions[k].excl(value)

# Eliminates one by one those that have a single valid position
var done = false
while not done:
  done = true
  for i in 0..<fields.len:
    if positions[i].len == 1:
      purge(i, positions[i].pop)
    else:
      done = false

var result = 1
for (i, field) in fields.pairs:
  if field[0].startsWith("departure"):
    result *= my_ticket[positions[i].pop]

echo result
