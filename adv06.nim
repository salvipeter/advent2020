import sequtils

var f: File
assert open(f, "adv06.txt") == true

var
  yes_count = 0
  questions = newSeq[bool](26)
  line: string
while f.readLine(line):
  if line == "":
    yes_count += questions.count(true)
    questions = newSeq[bool](26)
    continue
  for c in line:
    questions[ord(c)-ord('a')] = true
yes_count += questions.count(true)

echo yes_count
