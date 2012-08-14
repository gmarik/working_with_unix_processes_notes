# fork executes block for child process only
# then child exits

fork do
  puts "Child only:#{Process.pid}"
end

puts "Parent only:#{Process.pid}"

