# ruby  1.9+ implements Process.daemon like this
# https://github.com/ruby/ruby/blob/c852d76f46a68e28200f0c3f68c8c67879e79c86/process.c#L4817-4860
# which is equivalent to
def daemonize!

  # parent process exists, while
  # child process goes on
  exit if fork

  # the child process becomes session/process group leader
  Process.setsid

  # The forked process that had just become a process group and session group leader forks again and then exits.
  exit if fork
  # This newly forked process is no longer a process group leader nor a session leader. 
  # Since the previous session leader had no controlling terminal, and this process is not a
  # ￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼session leader, it's guaranteed that this process can never have a controlling terminal. 
  # Terminals can only be assigned to session leaders.
  # ￼￼￼￼This dance ensures that our process is now fully detached from a controlling terminal and will run to its completion.

  # This changes the current working directory to the root directory for the system. 
  # This isn't strictly necessary but it's an extra step to ensure that 
  # current working directory of the daemon doesn't disappear during its execution
  Dir.chdir '/'

  # This sets all of the standard streams to go to /dev/null , a.k.a. to be ignored. 
  # Since the daemon is no longer attached to a terminal session these are of no use anyway. 
  # They can't simply be closed because some programs expect them to always be available. 
  # Redirecting them to /dev/null ensures that they're still available to the program but have no effect.
  STDIN.reopen '/dev/null'
  STDOUT.reopen '/dev/null', 'a'
  STDERR.reopen '/dev/null', 'a'
end

daemonize!

#store PID to make sure process starts without error
fname = File.basename(File.expand_path(__FILE__))
File.open("/tmp/#{fname}.pid", 'w') do |f|
  f.write Process.pid
end

