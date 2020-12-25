import strutils

var f = open("adv19b.pl", fmWrite)
f.write("% -*- mode: prolog -*-\n")

for line in "adv19b.txt".lines:
  var i = line.find(':')
  if i != -1:
    f.write("term", line[0..<i], " -->")
    i += 2
    var sep = " "
    while i < line.len:
      if line[i] == '"':
        f.write(sep, '[', line[i+1], ']')
        sep = ", "
        i += 4
      elif line[i] == '|':
        f.write(";")
        sep = " "
        i += 2
      else:
        var j = line.find(' ', i)
        if j == -1:
          j = line.len
        f.write(sep, "term", line[i..<j])
        sep = ", "
        i = j + 1
    f.write(".\n")
  elif line != "":
    f.write("test(X) :- X = [", line.join(", "), "], term0(X, []).\n")
  else:
    f.write(line)
f.write("\nadv19(N) :- findall(X, test(X), Y), length(Y, N).\n")
