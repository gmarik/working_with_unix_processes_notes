#
# Processes Can Communicate
#

# when forked resources/file descriptors are shared/copied

reader, writer = IO.pipe

fork do
  reader.close # close child's copy

  10.times do
    writer.puts "Another one Bites the dust"
  end
end

writer.close # close parent's copy

while msg = reader.gets
  puts msg
end
