
# lets display the grid first and see how that looks
# remember that the off-by-one error is a factor here

# scan_template = [[-1, 1], [0, 1], [1, 1],
# [-1, 0], [0, 0], [1, 0],
# [-1, -1], [0, -1], [1, -1]]

board_grid = { "-1, 1" => "O", "0, 1" => "X", "1, 1" => "X", "-1, 0" => "X", "0, 0" => "O", "1, 0" => "O", "-1, -1" => "O", "0, -1" => "O", "1, -1" => "X" }

g1_top_row = ""; g1_mid_row = ""; g1_bottom_row = ""
top_row = ""; mid_row = ""; bottom_row = ""

def generate_next_gen(grid)
  # I'd prefer not to destructively alter the original board_grid for visual verfication
  # I don't like using "gen1_grid" as a name, wanted to make it flexible for multiple generation uses
  @gen1_grid = Marshal.load(Marshal.dump(grid))
  @gen1_grid.each do |key, value|
    puts "#{key} \t #{value}"
    neighbor_scan(key)
    break
    # neighbor_scan(key)
  end
    

end

def neighbor_scan(coordinates)
  scan_template = [[-1, 1], [0, 1], [1, 1],
                  [-1, 0], [0, 0], [1, 0],
                  [-1, -1], [0, -1], [1, -1]]
  current_zone = coordinates.split(", ")
  scan_template.each do |st|
    st[0] = st[0] + current_zone[0].to_i
    st[1] = st[1] + current_zone[1].to_i
  end
  filter_template = scan_template.select { |a, b| a.abs != 2 && b.abs != 2 }
  puts " filter_template "
  puts filter_template
  # ok, shift zero to the center zone of the grid, so the same method will for for checking all adjacent
  # Move that into a collection
  # Then remove from the collection anything with a "2"
  # Use the remaining collection as coordinates to check zone values
  # Push zone values into a different collection and total instances of O and X
  # compare to the rules
  # use compare results to modify the zone accordingly to O and X
 

end


#rudimentary UI

system("clear")

3.times { puts "" }

puts "\t\tGen 0\n"
puts ""

board_grid.each_with_index do |(key, value), i|
  # There's got to be a better way to do this
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

generate_next_gen(board_grid)

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

