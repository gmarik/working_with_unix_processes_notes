# this example shows how signal affects processes of the same Process Group
trap(:INT) do
  puts "#{Process.pid} received :INT signal"
  exit(0)
end

# every process is part of a Process Group
# here parent & child processes belong to same group

puts "Parent PID  #{Process.pid}"
puts "Parent PGRP #{Process.getpgrp}"

fork do

  puts "Child PID  #{Process.pid}"
  puts "Child PGRP #{Process.getpgrp}"

  puts "Sigals are forwarded from process leader to all processes within same process group"
  puts "Press ^C to exit both parent and child"

  loop do
    sleep 5
  end
end

Process.wait # parent waits for child
