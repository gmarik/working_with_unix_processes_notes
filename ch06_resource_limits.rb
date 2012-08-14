#
# Processes have Resource Limits
#

puts "Limits: #{Process.getrlimit(Process::RLIMIT_NOFILE).inspect}"

# Processes can have limits set with:
Process.setrlimit(Process::RLIMIT_NOFILE, 3)

# violating limits will raise errors
begin
  File.open('/dev/null')
rescue Errno::EMFILE => e
  puts e.message
end

# Other limits
puts "Allowed number of simultaneous processes #{Process.getrlimit(Process::RLIMIT_NPROC)}"
# see Process.getrlimit for more
