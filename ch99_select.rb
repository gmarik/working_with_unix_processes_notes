require 'socket'
# https://www6.software.ibm.com/developerworks/education/l-rubysocks/l-rubysocks-a4.pdf
sock1, sock2 = Socket.pair(:UNIX, :STREAM)

Thread.new(sock1) {|s| sleep 1; s.puts s }
Thread.new(sock2) {|s| sleep 4; s.puts s }

loop do
  #have only read_io for example
  read_io, write_io, err_io = [sock1, sock2, STDIN], nil, nil

  # select peeks into a read/write/err buffers whether any data is available
  read, write, err = select( read_io, write_io, err_io )
  for inp in read
    sock = case inp.fileno
    when sock1.fileno then inp
    when sock2.fileno then inp
    when STDIN.fileno then inp
    else raise "Unknown #{inp}"
    end

    # read from read socket so select starts waiting/blocking 
    # for the next event(available data)
    puts "from #{sock.fileno} #{sock.gets}"
  end
end
