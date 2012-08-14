#
# Processes are friendly
#

# fork(2) creates a new child process that's an exact copy of the parent process. This includes a copy of everything the parent process has in memory.
# Physically copying all of that data can be considerable overhead, so modern Unix systems employ something called copy-on-write semantics (CoW) to combat this.
# CoW delays the actual copying of memory until it needs to be written.

arr = [1,2,3]

unless fork
  # At this point the child process has been initialized.
  # Because of CoW the arr variable hasn't been copied yet.

  arr << 4

  # The above line of code modifies the array, so a copy of # the array will need to be made for this process before
  # it can modify it. The array in the parent process remains # unchanged.
end

puts Process.pid

sleep 100

## Why not CoW friendly?
# MRI's garbage collector uses a 'mark-and-sweep' algorithm. In a nutshell this means that when the GC is invoked it must iterate over every known object and write to it, either saying it should be garbage collected or it shouldn't. The important point here is that every time the GC runs every object in memory is written to.
# So, after forking, the first time that the GC runs will retract the benefit that copy- on-write provides.
# details from Phusion http://www.youtube.com/watch?v=ghLCtCwAKqQ
