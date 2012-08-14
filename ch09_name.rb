#
# Processes have names
#


puts "Process name: #{$PROGRAM_NAME}"

puts "And may be changed:"

$PROGRAM_NAME = 'wooot'
puts `\ps -ho pid,command #{Process.pid}`



