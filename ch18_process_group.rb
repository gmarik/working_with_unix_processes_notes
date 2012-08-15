#
# Process belong to process groups
#

#
# This example show how interrupting parent process doesn't affect child
# after child changes process group
#

trap(:INT) do
  puts "PID:#{Process.pid} received :INT signal, exiting..."
  puts "Watch for orphan child"
  exit(0)
end

puts "Press ^C to turn Child into an orphan"

# every process is part of a Process Group
puts "Parent PID:#{Process.pid} PGRP:#{Process.getpgrp}"

fork do
  puts "Child PID:#{Process.pid} PGRP:#{Process.getpgrp}"

  puts "Child quits parent's process group"
  # this will cause Child to become part of a new process group
  Process.setpgid(Process.pid, Process.pid)

  puts "Child PID:#{Process.pid} PGRP:#{Process.getpgrp} PPID #{Process.ppid}"

  5.times do
    puts "Child PID:#{Process.pid}, PPID: #{Process.ppid}"
    sleep 5
  end

  puts "Orphan child is now done"

  exit 0
end

Process.wait
