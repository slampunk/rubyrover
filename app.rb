require './rover.rb'

puts "Welcome to the Mars rover challenge"
puts ""
puts "You will be asked to provide a map size and (possibly multiple) rover position(s)"
puts "Enter a pair of integers for the map size"
map_dimensions = gets
raise ArgumentError, 'Map dimensions are a tuple of integers' unless /^\d+\s\d+$/.match(map_dimensions)
@roverInputs = []

def getRoverInfo
  lineNumber = 0
  lines = []

  validStart = /^\d+\s\d+\s[NSEW]$/
  invalidStartMsg = "invalid starting position supplied for rover, regex /^\d+\s\d+\s[NSEW]$/ is expected to pass"
  validPath = /^[LMR]+$/
  invalidPathMsg = "provided path contains invalid characters, regex /^[LMR]+$/ is expected to pass"

  puts ""
  puts "You may now provide rover initial position and pathing information"
  puts "As an example, you may enter information for two rovers as follows:"
  puts "1 2 E"
  puts "LMRLMRLMRLRML"
  puts "5 4 S"
  puts "MMRMRMRMRMLRLLRM"
  puts "You may enter your positioning and pathing input now:"
  loop do
    line = gets.chomp.strip
    break if line.empty?
    raise ArgumentError, lineNumber.odd? ? invalidPathMsg : invalidStartMsg unless (lineNumber.odd? ? validPath : validStart).match(line)
    lines.push(line)
    lineNumber+=1
  end
  #positions are now at even numbered indices
  keys = ['x', 'y', 'orientation']
  positions = lines.select.with_index { |val, index| index.even? }
                .map{ | val | val
                   # return a hash of the form {'x'=> .., 'y'=> .., 'orientation'=> ..}
                   val.split(/ /).map.with_index{ |val, index| [keys[index], val] }.to_h
                 }
  #whereas paths are now at odd numbered indices
  paths = lines.select.with_index { |val, index| index.odd? }
  raise LocalJumpError, "the last rover does not have pathing information" if positions.length > paths.length
  return {positions: positions, paths: paths}
end

roverInfo = getRoverInfo
puts roverInfo[:positions]
