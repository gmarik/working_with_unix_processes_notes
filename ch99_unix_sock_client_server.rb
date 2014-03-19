require 'socket'

# UNIXServer, UNIXSocket are just wrappers for
# listening and connecting sockets respectively

serv = UNIXServer.open(sfile = "/tmp/sock#{$$}")
c_sock = UNIXSocket.open(sfile)

s_sock = serv.accept

s_sock.puts('hi')
print c_sock.gets

puts [s_sock.fileno,'<->', c_sock.fileno].join
