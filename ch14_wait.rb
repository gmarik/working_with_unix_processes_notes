#
# Processes can wait
#

fork do
  5.times do
    sleep 1
    puts "I am a child PPID:#{Process.ppid}!"
  end
end

# blocking call instructing the parent process to wait for one of its child processes to exit before continuing
cpid = Process.wait

puts "Child PID:#{cpid} finished"

puts "Parent process finished..."

#
# - `wait` waits for any child process
# - `waitpid`(pid) waits for child process with pid
# - `wait2` returns [pid, exit_status] works as wait
# - `waitpid2` return [pid, exit_status] works as waitpid
#

# waiting for non existing child raises error
begin
  pid, status = Process.wait2
rescue => e
  puts "#{e.class.name} #{e.message}"
end
