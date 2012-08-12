# Pipes are like anonymous Files

reader, writer = IO.pipe

writer.write "Hello"
writer.write " "
writer.write "World"

writer.close

# reader.read is reading(and blocking) until EOF, 
# so writer.close before is necessary to not block forever
puts reader.read

begin
  reader.write "HI"
rescue IOError => e
  puts "Reader #{e.message}"
end
