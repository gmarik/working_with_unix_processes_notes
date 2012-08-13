# This example show how exiting process group by a process affects signal handling
#
trap(:INT) do
  puts "PID:#{Process.pid} received :INT signal, exiting..."
  puts "Watch for zombie child"
  exit(0)
end

# every process is part of a Process Group
puts "Parent PID:#{Process.pid} PGRP:#{Process.getpgrp}"

fork do
  puts "Child PID:#{Process.pid} PGRP:#{Process.getpgrp}"

  puts "Child quits parent's process group"
  # this will cause Child to become part of new process group
  Process.setpgid(Process.pid, Process.pid)

  puts "Child PID:#{Process.pid} PGRP:#{Process.getpgrp} PPID #{Process.ppid}"

  puts "Press ^C to turn Child into a zombie"

  5.times do
    puts "Child PID:#{Process.pid}, PPID: #{Process.ppid}"
    sleep 5
  end

  puts "Zombie is Dead"

  exit 0
end

Process.wait
