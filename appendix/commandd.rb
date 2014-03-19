require 'socket'
require 'shellwords'

# TODO:
# - prints bailing N times(number of workers) after process termination
# - echo "bash -l -c 'echo ok'"|socat - UNIX-CONNECT:/tmp/commandd.sock
#   breaks with: commandd.rb:59:in `copy_stream': Broken pipe - write (Errno::EPIPE)
#   WHY?

# Examples:
# echo "echo ok"|socat - UNIX-CONNECT:/tmp/commandd.sock
# => ok
# 

# Open a socket.
sockf = '/tmp/commandd.sock'
File.unlink(sockf) if File.stat(sockf).socket?

serv = UNIXServer.new(sockf)

reader, writer = UNIXSocket.pair(:STREAM)

trap(:EXIT) { serv.close }

# prefork-server handles incoming connections

3.times do
  fork do
    trap(:INT) { exit }

    # not needed in child process
    reader.close

    loop {
      conn = serv.accept
      # client socket fd gets passed down pipe
      # to be used by one of the workers
      writer.send_io conn
    }
    exit
  end
end

trap(:INT) { puts "bailing #{Process.pid}" ; exit }

# Workers

3.times do
  fork do
    # not needed in child process
    writer.close

    # worker loop
    loop do
      # get client socket FD
      client = reader.recv_io

      cmd = Shellwords.split(client_cmd = client.gets)

      puts "Running #{cmd}:#{client_cmd}"

      # launch process and connect its stderr to client's IO
      IO.popen(cmd, err: client) do |cmd_out|
        # copy stdout into clients IO
        IO.copy_stream(cmd_out, client)
        client.close
      end
    end
  end
end

Process.waitall
