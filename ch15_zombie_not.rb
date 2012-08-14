#
# Processes can detach children
#

# Detach spawns a dedicated thread to wait for a child specified by pid

child_pid = fork do
  puts "I'm a zombie temporarily PID:#{Process.pid}"
end

puts "Child has been detached: not a zombie"
Process.detach(child_pid)

puts 'Done'

