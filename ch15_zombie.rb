#
# Processes can become zombies
#

#  On Unix operating systems, a zombie process or defunct process is a process that has completed execution 
#  but still has an entry in the process table, allowing the process that started it to read its exit status. 
#  In the term's colorful metaphor, the child process has died but has not yet been reaped.
#  http://wiki.answers.com/Q/What_is_Zombie_Process_and_Orphan_Process

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


