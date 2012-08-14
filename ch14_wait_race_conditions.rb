#
#
#
# The kernel queues up information about exited processes so that the parent 
# always receives the information in the order that the children exited.

# We create two child processes.
2.times do
  fork do
    # Both processes exit immediately.
    abort "Finished!"
  end
end

# The parent process waits for the first process, then sleeps for 5 seconds.
# # In the meantime the second child process has exited and is no
# longer running.

puts Process.wait
sleep 5

# The parent process asks to wait once again, and amazingly enough, the second
# # process' exit information has been queued up and is returned here.
puts Process.wait
