import sets, strutils

var f: File
assert open(f, "adv08.txt") == true

type Operation = enum opAcc, opJmp, opNop
type Program = seq[(Operation, int)]
type Result = (bool, int)

func runsCorrectly(program: Program): Result =
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
    if ip == program.len:
      result = (true, ax)
      break
    if ip < 0 or ip > program.len:
      break

var
  line: string
  program: Program
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

for op in program.mitems:
  case op[0]:
    of opAcc:
      continue
    of opJmp:
      op[0] = opNop
      var (ok, val) = runsCorrectly(program)
      if ok:
        quit $val
      op[0] = opJmp
    of opNop:
      op[0] = opJmp
      var (ok, val) = runsCorrectly(program)
      if ok:
        quit $val
      op[0] = opNop
