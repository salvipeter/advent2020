import sets, strutils, tables

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

var count = 0
for i in 0..<numToName.len:
  var dangerous = false
  for p in possible.values:
    if i in p:
      dangerous = true
      break
  if not dangerous:
    for f in foods:
      if i in f[0]:
        inc count

echo count
