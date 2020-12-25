import strutils

var f: File
assert open(f, "adv02.txt") == true

var line: string
var valid_count = 0
while f.readLine(line):
  let dash = line.find('-')
  let space = line.find(' ')
  let first = parseInt(line[0..<dash])
  let second = parseInt(line[dash+1..<space])
  let c = line[space+1]
  let str = line[space+3..^1]
  if str[first] == c xor str[second] == c:
    inc valid_count

echo valid_count
