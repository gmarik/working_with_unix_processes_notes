require 'thread'
require 'socket'

Thread.abort_on_exception = true

sockf = ARGV[0]

q = Queue.new

threads = (1..40).to_a.map do |id|
  Thread.new(q, id) do |q, id|
    loop do
      csock = UNIXSocket.new(sockf)
      sleep rand(5)
      csock.puts(id)
      q.push(id)
      csock.close
    end
  end
end

Thread.new(q) do |q|
  loop do
    puts "sent #{q.pop}"
  end
end.join

threads.map {|t| t.join }
