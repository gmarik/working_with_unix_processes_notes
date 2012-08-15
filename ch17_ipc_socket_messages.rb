# Socket unlike Pipe is 
# - bidirectional
# - messaging paradigm
#
require 'socket'

child_sock, parent_sock = Socket.pair(:UNIX, :DGRAM, 0)
MAXLEN = 1000

fork do
  parent_sock.close # not needed in child process

  4.times do
    instr = child_sock.recv(MAXLEN)
    child_sock.send("#{instr} accomplished!", 0)
  end
end

child_sock.close # not needed in parent process

2.times do
  parent_sock.send("Heavy lifting", 0)
end

2.times do
  parent_sock.send("Feather lifting", 0)
end

4.times do
  puts parent_sock.recv(MAXLEN)
end
