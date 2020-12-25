import sequtils, strutils

const cups = [3, 6, 4, 2, 8, 9, 7, 1, 5]

func playOneRound(labels: seq[int]): seq[int] =
  var dest = labels[0]
  while dest in labels[0..3]:
    dec dest
    if dest == 0:
      dest = labels.len
  dest = labels.find dest
  result.add labels[4..dest]
  result.add labels[1..3]
  result.add labels[dest+1..^1]
  result.add labels[0]

var labels = cups.toSeq
for iter in 1..100:
  labels = labels.playOneRound
let i = labels.find(1)
echo labels.cycle(2)[i+1..i+labels.len-1].join("")
