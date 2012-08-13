# ruby  1.9+ implements Process.daemon like this
# https://github.com/ruby/ruby/blob/c852d76f46a68e28200f0c3f68c8c67879e79c86/process.c#L4817-4860
# which is equivalent to
def daemonize!

  # parent process exists, while
  # child process goes on
  exit if fork

  # the child process becomes session/process group leader
  Process.setsid

   # the child process exists, spawning
   # child2 process which goes on
   exit if fork

   # set CWD(to avoid situation where current CWD gets deleted/unmounted/disappears)
   Dir.chdir '/'

   # reset any terminal input/output
   STDIN.reopen '/dev/null'
   STDOUT.reopen '/dev/null', 'a'
   STDERR.reopen '/dev/null', 'a'
end

daemonize!

#store PID to make sure process starts
fname = File.basename(File.expand_path(__FILE__))
File.open("/tmp/#{fname}.pid", 'w') do |f|
  f.write Process.pid
end

