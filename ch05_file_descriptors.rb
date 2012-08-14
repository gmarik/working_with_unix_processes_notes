#
# Process have File Descriptors
#


# Everything is a File
# Descriptors represent resources

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

