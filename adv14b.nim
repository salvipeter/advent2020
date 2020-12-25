import algorithm, bitops, lists, strutils, tables

proc concat[T](a: var SinglyLinkedList[T], b: SinglyLinkedList[T]): SinglyLinkedList[T] =
  if a.tail != nil:
    a.tail.next = b.head
  a.tail = b.tail
  if a.head == nil:
    a.head = b.head
  a

func applyMask(mask: seq[char], value: int, start = 0): SinglyLinkedList[int] =
  var value = value
  if start >= mask.len:
    var list = initSinglyLinkedList[int]()
    list.append(value)
    return list
  let
    exp = 1 shl start
    all_one = 1 shl mask.len - 1
  if mask[start] == '1':
    value = bitor(value, exp)
  if mask[start] != 'X':
    return applyMask(mask, value, start + 1)
  var
    res1 = applyMask(mask, bitor(value, exp), start + 1)
    res2 = applyMask(mask, bitand(value, all_one - exp), start + 1)
  res1.concat(res2)

var
  mask: seq[char]
  memory: Table[int,int]
for line in "adv14.txt".lines:
  if line[0..3] == "mask":
    mask = line[7..^1].reversed
  else:
    let
      index_end = line.find(']')
      index = line[4..<index_end].parseInt
      value = line[index_end+4..^1].parseInt
      masked = applyMask(mask, index)
    for i in masked:
      memory[i] = value

var sum = 0
for v in memory.values:
  sum += v
echo sum
