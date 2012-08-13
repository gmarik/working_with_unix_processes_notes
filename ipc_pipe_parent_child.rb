reader, writer = IO.pipe

fork do
  # fork copies reader, writer to child process
  reader.close # close child's copy

  10.times do
    writer.puts "Another one Bites the dust"
  end
end

writer.close # close parent's copy

while msg = reader.gets
  puts msg
end
