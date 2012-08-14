#
# Processes can Fork
#

# Child processes inherit
# 1) copy of all of the memory in use by the parent process
# 2) copy of all of the open file descriptors


# fork clones current process

# fork returns twice

if child_pid = fork
  # child_pid == child PID in parent process
  puts "It's the parent #{Process.pid}"
else
  # child_pid == nil in child process
  puts "It's the child #{Process.pid}"
end

# both processes continue execution
puts Process.pid

# both exit

