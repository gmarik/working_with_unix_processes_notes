#
# Processes can wait
#

# Zombie is a ended child process end of which hasn't been `wait`-ed by parent

child_pid = fork do
  puts "I'm a zombie temporarily PID:#{Process.pid}"
end

sleep 2

puts `\ps -ho pid,state #{child_pid}`

sleep 1

puts "Waiting for child_PID:#{child_pid}"

Process.wait

puts "Child has been waited for, so it's not a zombie anymore"
puts 'Done'


