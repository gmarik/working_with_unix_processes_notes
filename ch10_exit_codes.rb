#
# Processes have exit codes
#

system('echo "exit 12"| ruby')
puts "Exit status: #{$?.exitstatus}"

# one may use exit, exit!, abort, abort!, raise to end process
