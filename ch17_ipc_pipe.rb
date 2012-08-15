#
# Processes Can Communicate
#

# Pipe is like anonymous File
# has similar interface, with some exceptions
# doesn't have #path, #name, etc (as it's anonymous)
# see ruby IO for more

# Pipe is uni-directional
# writer writes into
# reader reads from
# writer -> reader

reader, writer = IO.pipe

begin
 reader.write "Hi" 
rescue IOError => e
  puts e.message
end


begin
 puts writer.read
rescue IOError => e
  puts e.message
end

writer.write "Hello"
writer.write " "
writer.write "World"

# writer.close is necessary so reader to not block forever waiting for EOF
writer.close

puts reader.read
