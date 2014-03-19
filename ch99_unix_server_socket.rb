require 'socket'

# unix_server_socket is a shortcut
# for creating a listening unix socket
#
# server socket
s_ssock = Socket.unix_server_socket("/tmp/sock")
# client connection
c_sock = Socket.unix("/tmp/sock")

# accept client
s_sock, addr_info = s_ssock.accept

#communicate
c_sock.puts("ok")
puts s_sock.gets






