import sets, strutils

var f: File
assert open(f, "adv08.txt") == true

type Operation = enum opAcc, opJmp, opNop

var
  line: string
  program: seq[(Operation, int)]
while f.readLine(line):
  let op = case line[0..2]:
             of "acc":
               opAcc
             of "jmp":
               opJmp
             of "nop":
               opNop
             else:
               raise newException(ValueError, "invalid operation")
  program.add((op, parseInt(line[4..^1])))

var
  seen: HashSet[int]
  ax = 0
  ip = 0
while not seen.contains(ip):
  seen.incl(ip)
  case program[ip][0]:
    of opAcc:
      ax += program[ip][1]
      inc ip
    of opJmp:
      ip += program[ip][1]
    of opNop:
      inc ip

echo ax
