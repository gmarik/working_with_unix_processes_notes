# fork clones current process

# fork returns twice

if fork 
  # fork returns child PID in parent process
  puts "It's the parent #{Process.pid}"
else
  # fork returns nil in child process
  puts "It's the child #{Process.pid}"
end

# both processes continue execution
puts Process.pid

# both exit

