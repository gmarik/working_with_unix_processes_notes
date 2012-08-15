#
# Orphaned Processes
#

#
# An orphan process is a computer process whose parent process has finished or terminated. 
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
