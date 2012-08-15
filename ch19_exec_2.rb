#
# Processes can spawn("shell out") to run other processes
#

# Kernel#system
#
system('\ps')
system('\ps', '-h')
system('\ps | grep ruby')



# Kernel#`
#
`\ps`
`\ps -h`
%x[\ps | grep ruby]



# Process.spawn - nonblocking (1.9+)
# has tons of optiosn
#
# forked child processes share file desciptors
# but that's not the case with spawn
# it closes all file descriptors except STDIN, STDOUT, STDERR
# see docs for more examples

pid = Process.spawn({'MSG' => 'woot'}, %q[ruby -e 'puts ENV["MSG"]'])
pid, status = Process.waitpid2(pid)
puts "#{pid} finished with $?=#{status.exitstatus}"



# Process.popen
# opens pipe to a command and gives access

IO.popen('ruby', 'w') do |writer|
  writer.write(%q[puts "OK"])
end


IO.popen('ls -l|wc -l', 'r') do |reader|
  puts reader.read
end



# popen3 allow
require 'open3'
Open3.popen3('ruby') { |stdin, stdout, stderr|
  stdin.puts "puts 1+1"
  stdin.close
  puts stdout.read
}
