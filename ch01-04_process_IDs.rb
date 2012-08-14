#
# Processes have IDs
#

# Process ID
puts "PID: #{Process.pid}"

# Parent ID: PPIDs
puts "Parent PID: #{Process.ppid}"

# Group ID
puts "Process Group ID: #{Process.getpgrp}"
