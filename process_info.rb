# Processes have IDs
puts "PID: #{Process.pid}"

# Processes have IDs
puts "Parent PID: #{Process.ppid}"
#
# Processes have IDs
puts "Process Group ID: #{Process.getpgrp}"




# Process have file descriptors
# Everything is a File
# Reserved Standard Streams
puts "STDIN: #{STDIN.fileno}, STDOUT: #{STDOUT.fileno}, STDERR: #{STDERR.fileno}"

# Other
File.open('/etc/hosts') do |f|
  puts "/etc/hosts ID:#{f.fileno}"
end
# Descriptor IDs are reused once resources are freed/closed
File.open('/etc/passwd') do |f|
  puts "/etc/passwd ID:#{f.fileno}"
end



#
# Processes have Environment
#
puts "User: #{ENV['USER']}"


#
# Processes have arguments
#
puts "Args: #{ARGV}"


#
# Processes have names
#
puts "Process name: #{$PROGRAM_NAME}"
$PROGRAM_NAME = 'wooot'
puts `ps #{Process.pid}`


#
# Processes have exit codes
#
system('exit 12')
puts "Exit status: #{$?.exitstatus}"

# one may use exit, exit!, abort, abort!, raise to end process

#
# Processes Have resource Limits
#
puts "Limits: #{l = Process.getrlimit(:NOFILE)}"

# Processes can have limits set with:
Process.setrlimit(:NOFILE, 3)

# violating limits will raise errors
begin 
  File.open('/dev/null')
rescue Errno::EMFILE => e
  puts e.message
end

exit 0
