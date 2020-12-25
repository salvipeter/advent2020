import strutils

var f: File
assert open(f, "adv02.txt") == true

var line: string
var valid_count = 0
while f.readLine(line):
  let dash = line.find('-')
  let space = line.find(' ')
  let min = parseInt(line[0..<dash])
  let max = parseInt(line[dash+1..<space])
  let c = line[space+1]
  let str = line[space+4..^1]
  let found = str.count(c)
  if min <= found and found <= max:
    inc valid_count

echo valid_count
