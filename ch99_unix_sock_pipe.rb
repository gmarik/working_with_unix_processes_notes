require 'socket'

s1, s2 = UNIXSocket.pair(:STREAM)

s1.puts "hello"
print(val = s2.gets)

s2.puts(val.reverse)

print s1.getc # ??
print s1.gets
