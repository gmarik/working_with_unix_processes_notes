require 'socket'

# unix server socket is a Socket that accepts
# client connections
# differences betwee UNIXServer is that the
# latter is not a socket
# TODO: elaborate on said above

# server socket
s_ssock = Socket.unix_server_socket("/tmp/sock")
# client connection
c_sock = Socket.unix("/tmp/sock")

# accept client
s_sock, addr_info = s_ssock.accept

#communicate
c_sock.puts("ok")
puts s_sock.gets






