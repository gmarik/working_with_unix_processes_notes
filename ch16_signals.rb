#
# Processes can receive signals
#
# man kill(1)

# Below example shows that using blocking Process.wait
# sometimes may be not acceptable in case parent has a work to do
# therefore nonblocking variant is used
# also
# kernel signals once per group of children
# which requires looping until all children processed

child_processes = 3

# fork 3 child processes.
child_processes.times do
  fork do
    # pretend doing work
    sleep 3
  end
end

# Sync $stdout so the call to #puts in the CHLD handler isn't
# buffered. Can cause a ThreadError if a signal handler is
# interrupted after calling #puts. Always a good idea to do
# this if your handlers will be doing IO.
$stdout.sync = true

done = false

# The parent process will be busy doing some intense mathematics.
# But still wants has to handle children that exits.

# By trapping the :CHLD signal the parent process will be notified by the kernel
# when one of its children exits.
trap(:CHLD) do
  begin
    # nonblocking version
    while pid = Process.wait(-1, Process::WNOHANG)
      puts pid
      child_processes -= 1

      # exit once all child processes end
      done = child_processes.zero? and break
    end

  # Error is raised when there are no children
  # even when using non-blocking variant
  rescue Errno::ECHILD
    # no more children
    puts 'no more children'
  end
end

# Work it.
begin
  sleep 1
end until done

puts 'All done!'
