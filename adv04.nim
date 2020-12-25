import strutils

var f: File
assert open(f, "adv04.txt") == true

func validPassport(fields: seq[string]): bool =
  fields.len == 8 or fields.len == 7 and not fields.contains("cid")

var
  valid_count = 0
  found: seq[string]
  line: string
while f.readLine(line):
  if line == "":
    if validPassport(found):
      inc valid_count
    found = @[]
    continue
  var next = 3
  while next > 0:
    found.add(line[next-3..<next])
    next = line.find(':', next + 1)

# Process last one
if validPassport(found):
  inc valid_count

echo valid_count
