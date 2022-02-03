
# lets display the grid first and see how that looks
# remember that the off-by-one error is a factor here

# scan_template = [[-1, 1], [0, 1], [1, 1],
                # [-1, 0], [0, 0], [1, 0],
                # [-1, -1], [0, -1], [1, -1]]

# Originally was going to use an array of arrays, then after I stepped away from it,
# I realized that I would have to have corner zone methods to check the surrounding values, 
# side middle (such as -1, 0) methods and a middle method.  And those methods would have to rotate
# 90 degrees as well.  
# Then I realized that it, if I could make the center zone 0,0, then I just have to reject any 
# out-of-bounds on a single 360 degree scan on each zone because every one of them would have a
# 2 coordinate and I can filter out those.
# So that made it essential to use a hash.
@board_grid = { "-1, 1" => "O", "0, 1" => "X", "1, 1" => "X", 
              "-1, 0" => "X", "0, 0" => "O", "1, 0" => "O", 
              "-1, -1" => "O", "0, -1" => "O", "1, -1" => "X" }

g1_top_row = ""; g1_mid_row = ""; g1_bottom_row = ""
top_row = ""; mid_row = ""; bottom_row = ""

def generate_next_gen(grid)
  # I'd prefer not to destructively alter the original @board_grid for visual verfication
  # I don't like using "gen1_grid" as a name, wanted to make it flexible for multiple generation uses
  # This method seems to be the best place to drive the overall script.
  @gen1_grid = Marshal.load(Marshal.dump(grid))
  @gen1_grid.each do |key, value|
    puts ""
    puts " current zone "
    puts "#{key} \t #{value}"
    puts ""
    neighbor_scan(key, value)

    # break # TO REMOVE
    # neighbor_scan(key)
  end


end

def neighbor_scan(coordinates, zone_value)
  scan_template = [[-1, 1], [0, 1], [1, 1],
                  [-1, 0], [1, 0],
                  [-1, -1], [0, -1], [1, -1]]
  scan_coordinates = []
  scanned_values = []

  current_zone = coordinates.split(", ")  
  # takes the argument for the zone we are currently in
  scan_template.each do |st| 
    # the scan_template checks each zone of the perimeter from 0,0.  
    # This block adds the current coordinates to the scan template to scan each zone.
    st[0] = st[0] + current_zone[0].to_i
    st[1] = st[1] + current_zone[1].to_i
  end
  # filter_template removes all the out of bounds zones the template generated
  filter_template = scan_template.select { |a, b| a.abs != 2 && b.abs != 2 }
  # This puts together the arrays to more easily use them to match to the @board_grid keys
  filter_template.each do |ft|
    scan_coordinates << ft.join(", ")
  end
  # This block finds the values surrounding each zone one at a time
  # It stores all the values in the scanned_values array
  scan_coordinates.each do |sc|
    @board_grid.select do |key, value| 
      scanned_values << value if key == sc
    end
  end
  puts " scanned values "
  puts ""
  puts scanned_values
  puts ""
  puts ""
  puts ""

 

end


#rudimentary UI

system("clear")

3.times { puts "" }

puts "\t\tGen 0\n"
puts ""

@board_grid.each_with_index do |(key, value), i|
  # I wanted to see the original to visually verify what is working
  # There's got to be a better way line the values in 3x3 rows
  case i
  when 0..1
    top_row += "#{value} "
  when 2
    top_row += "#{value}"
  when 3..4
    mid_row += "#{value} "
  when 5
    mid_row += "#{value}"
  when 6..7
    bottom_row += "#{value} "
  when 8
    bottom_row += "#{value}"
  end
end

puts "\t\t" + top_row
puts "\t\t" + mid_row
puts "\t\t" + bottom_row

3.times { puts "" }

puts "\t\tGen 1\n"
puts ""

generate_next_gen(@board_grid)

@gen1_grid.each_with_index do |(key, value), i|
  case i
  when 0..1
    g1_top_row += "#{value} "
  when 2
    g1_top_row += "#{value}"
  when 3..4
    g1_mid_row += "#{value} "
  when 5
    g1_mid_row += "#{value}"
  when 6..7
    g1_bottom_row += "#{value} "
  when 8
    g1_bottom_row += "#{value}"
  end
end

puts "\t\t" + g1_top_row
puts "\t\t" + g1_mid_row
puts "\t\t" + g1_bottom_row

3.times { puts "" }

  # DONE - ok, shift zero to the center zone of the grid, so the same method will for for checking all adjacent
  # DONE - Move that into a collection
  # DONE - Then remove from the collection anything with a "2"
  # DONE - Use the remaining collection as coordinates to check zone values
  # DONE - Push zone values into a different collection and total instances of O and X
  # compare to the rules
  # use compare results to modify the zone accordingly to O and X