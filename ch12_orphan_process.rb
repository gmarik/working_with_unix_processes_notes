#
# Orphaned Processes
#


# Orphaned Process - a child process with original parent process dead
# gets assgned a Init Process(PID=1) as a parent

fork do

  5.times do
    child = (ppid = Process.ppid) == 1 ? 'an orphan':'a child'
    puts "I'm #{child}! PPID:#{Process.ppid}"
    sleep 1
  end
end

sleep 1
abort "Parent process died..."
