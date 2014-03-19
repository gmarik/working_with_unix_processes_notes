require 'socket'

# Open a socket.
sockf = '/tmp/commandd.sock'
File.unlink(sockf) if File.stat(sockf).socket?

serv = UNIXServer.new(sockf)

reader, writer = IO.pipe

('A'..'F').to_a.map { |p|
   fork do
    reader.close
    Signal.trap(:INT) { exit }
    loop {
      conn = serv.accept
      writer.puts "#{p} <- #{conn.gets}"
      conn.close
    }
  end
}

fork do
  writer.close
  loop do
    puts reader.gets
  end
end

Process.waitall



