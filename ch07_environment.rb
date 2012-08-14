#
# Processes have Environment
#

puts "User: #{ENV['USER']}"

# Child processes inherit environment
ENV['MSG'] = 'zoom'
puts `echo $MSG`
