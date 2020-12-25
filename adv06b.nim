import sequtils

var f: File
assert open(f, "adv06.txt") == true

var
  yes_count = 0
  questions = newSeq[bool](26)
  line: string
while f.readLine(line):
  if line == "":
    yes_count += questions.count(false)
    questions = newSeq[bool](26)
    continue
  var one_answer = newSeq[bool](26)
  for c in line:
    one_answer[ord(c)-ord('a')] = true
  for i in 0..<26:
    if not one_answer[i]:
      questions[i] = true
yes_count += questions.count(false)

echo yes_count
