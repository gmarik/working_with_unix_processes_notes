#
# Processes can
# - ignore
# - handle(and redefine) signals
#
# Signals are asynchronous means of communication
# here child process tries to kill parent process
# while parent is busy sleeping
# parent handles signals by interrupting from indefinite sleep


$stdout.sync = true

cpid = fork do
  puts "Aborting"
  Process.kill(:ABRT, Process.ppid)

  puts "Leaving"
  Process.kill(:QUIT, Process.ppid)

  puts "Assault"
  Process.kill(:INT, Process.ppid)
end

# do not create zombies
Process.detach(cpid)

# system :INT handler is just a "DEFAULT" string
system_handler = trap(:INT) {
  puts "someone just interrupted me"
  puts "calling system"
  if system_handler.respond_to?(:call)
    system_handler.call
  else
    puts "Someone help"
  end

  exit
}

# Redefine preserving
# preserve custom :INT signal handler
orig_handler = trap(:INT) {
  puts "What?"
  orig_handler.call
}

# Ignore signal
trap(:ABRT, "IGNORE")

# Redefine
trap(:QUIT) {
  puts "IGNORE"
}
sleep

puts "Shouldn't happen"

