#
# Processes can spawn("shell out") to run other processes
#

# All variations are some kind of fork + exec combination
# - fork is used to create separate process
# - exec to replace the child process with one needed

# NOTE: passwing array of arguments is preffereable as it enables exec to run the program directly 
# instead delegating execution to shell in case of a single string
#

exec('ruby', '-e', "puts 'Ok'")

# this statement is never run as process exits after above statement
puts "done"
