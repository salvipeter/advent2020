import algorithm, sequtils, sets, strutils, tables

var
  nameToNum: Table[string, int]
  numToName: seq[string]
  foods: seq[(seq[int], seq[string])]
  allergens: HashSet[string]
for line in "adv21.txt".lines:
  let
    i = line.find('(')
    garbled = line[0..i-2].split(' ')
    english = line[i+10..^2].split(", ")
  var numbers: seq[int]
  for g in garbled:
    if g in nameToNum:
      numbers.add nameToNum[g]
    else:
      let n = nameToNum.len
      nameToNum[g] = n
      numToName.add g
      numbers.add n
  foods.add (numbers, english)
  for e in english:
    allergens.incl e

var possible: Table[string, HashSet[int]]
for f in foods:
  for allergen in f[1]:
    if allergen in possible:
      possible[allergen] = possible[allergen].intersection(f[0].toHashSet)
    else:
      possible[allergen] = f[0].toHashSet

var danger: seq[(string, string)]
while true:
  var changed = false
  for name in allergens:
    if possible[name].len == 1:
      let i = possible[name].pop
      danger.add (numToName[i], name)
      for other in allergens:
        possible[other].excl i
      changed = true
  if not changed:
    break

echo danger.sortedByIt(it[1]).mapIt(it[0]).join(",")
