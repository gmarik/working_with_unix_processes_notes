

reader, writer = IO.pipe


fork do
  reader.close # child process doesn't need this

  10.times do
    writer.puts "Another one Bites the dust"
  end
end

writer.close # parent doesn't need this

while msg = reader.gets
  puts msg
end
