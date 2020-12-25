import strutils

var f: File
assert open(f, "adv13.txt") == true

let arrival = f.readLine.parseInt
var
  best: int
  wait = int.high
for bus in f.readLine.split(','):
  if bus == "x":
    continue
  let bus_num = bus.parseInt
  var w = arrival mod bus_num
  if w == 0:
    quit "0", 0
  w = bus_num - w
  if w < wait:
    wait = w
    best = bus_num

echo best * wait
