import strutils

var f: File
assert open(f, "adv04.txt") == true

func validPassport(fields: seq[string]): bool =
  fields.len == 8 or fields.len == 7 and not fields.contains("cid")

func validField(field: string, value: string): bool =
  try:
    case field:
      of "byr":
        let x = parseInt(value)
        result = x >= 1920 and x <= 2002
      of "iyr":
        let x = parseInt(value)
        result = x >= 2010 and x <= 2020
      of "eyr":
        let x = parseInt(value)
        result = x >= 2020 and x <= 2030
      of "hgt":
        let x = parseInt(value[0..^3])
        if value[^2..^1] == "cm":
          result = x >= 150 and x <= 193
        elif value[^2..^1] == "in":
          result = x >= 59 and x <= 76
      of "hcl":
        result = value.len == 7 and value[0] == '#'
        discard parseHexInt(value[1..^1])
      of "ecl":
        result = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value)
      of "pid":
        result = value.len == 9
        discard parseUInt(value)
      of "cid":
        result = true
  except:
    result = false

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
    let
      field = line[next-3..<next]
      space = line.find(' ', next)
      value = if space < 0: line[next+1..^1] else: line[next+1..<space]
    if validField(field, value):
      found.add(field)
    next = line.find(':', next + 1)

# Process last one
if validPassport(found):
  inc valid_count

echo valid_count
