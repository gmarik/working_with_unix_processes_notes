require 'socket'

# Open a socket.
socket = TCPServer.open('0.0.0.0', 8080)

#Preload app code.
# require 'config/environment'

# Forward any relevant signals to the child processes.
[:INT, :QUIT].each do |signal|
  Signal.trap(signal) {
    wpids.each { |wpid| Process.kill(signal, wpid) }
  }
end

# For keeping track of child process pids.
wpids = []

5.times {
  wpids << fork do
    loop {
      connection = socket.accept
      puts "#{Process.pid} accepted"
      connection.puts 'Hello World!'
      connection.close
    }
  end
}

Process.waitall
