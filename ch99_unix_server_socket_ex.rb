require 'socket'

include Socket::Constants

#extended version of ch99_unix_server_socket.rb

s_ssock = Socket.new( :UNIX, :STREAM, 0 )
s_ssock.bind( socaddr = Socket.pack_sockaddr_un("/tmp/sock#{$$}") )
# s_sock.setsockopt(:SOCKET, :REUSEADDR, true)
s_ssock.listen( 5 )

# client connection
c_sock = Socket.new( :UNIX, :STREAM, 0 )
c_sock.connect( socaddr )

# accept client
s_sock, addr_info = s_ssock.accept

#communicate
c_sock.puts("ok")
puts s_sock.gets






