import strutils

var f: File
assert open(f, "adv13.txt") == true

discard f.readLine
let buses = f.readLine.split(',')

var
  start = 0
  step = 1
for i in 0..<buses.len:
  if buses[i] == "x":
    continue
  let bus = buses[i].parseInt
  while (start + i) mod bus != 0:
    start += step
  step *= bus

echo start
