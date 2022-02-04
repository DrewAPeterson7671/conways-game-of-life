#!/usr/bin/ruby
require ('./lib/board_grid.rb')
require ('./lib/area_scan.rb')
require ('./lib/game_rules.rb')

# First I wanted to make the display of the grids for visual confirmation
# If you look to my git history, I used puts to display each step and confirm it before proceeding
# I was very wary of off-by-one error potential at every step

# Originally, I was going to use an array of arrays, then after I stepped away from it for a few hours,
# I realized that I would have to have methods to check the surrounding neighbor values of corners zones (such as 
# the upper left corner), side middle zone (the middle X in the left side column) methods and a middle
# zone method.  And those methods (except for middle zone) would have to rotate 90 degrees for 
# each counterpart.  I needed a deeper abstraction.  The only simple perimeter scan of zone values 
# would be the middle zone because it scans 360 degrees around without looking outside of the bounds.  
# It seemed to me the best way was to find a way to make a single 360 scan method.  But how to deal 
# with the scan looking out of the boundaries of the game?  I stepped away from coding to dinner 
# and it I came up with a solution.  If Then I realized that, if I could make the center zone 0,0, 
# then I just have to reject any out-of-bounds on a single 360 degree scan on each zone because the 
# out of bounds zone would automatically have a absolute value of 2.  And that could be filtered out, covering all directions. 
# So that made it essential to use a hash.


## CHANGING @board_grid from an instance variable


# Variables to aid in a rudimentary UI
g1_top_row = ""; g1_mid_row = ""; g1_bottom_row = ""
top_row = ""; mid_row = ""; bottom_row = ""

# def generate_next_gen(grid)
#   # I'd prefer not to destructively alter the original board_grid for visual verfication
#   # I don't like using "gen1_grid" as a name, wanted to make it flexible for multiple generation uses
#   # This method seems to be the best place to drive the overall script.
#   @gen1_grid = Marshal.load(Marshal.dump(grid))
#   @gen1_grid.each do |key, value|
#     new_value = neighbor_scan(key, value)
#     # Here is where the new value replaces the old values
#     @gen1_grid[key] = new_value
#   end
# end

#rudimentary UI
system("clear")
3.times { puts "" }
puts "\t\tGen 0\n"
puts ""

::BoardGrid.instance_variable_get(:@board_grid).each_with_index do |(key, value), i|
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

# this initiates the methods and drives the script forward
BoardGrid.generate_next_grid()

#check if attr_reader can be accessed here?
::BoardGrid.instance_variable_get(:@generation_grid).each_with_index do |(key, value), i|
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

# Rudimentary checklist of tasks
  # DONE - ok, shift zero to the center zone of the grid, so the same method will for for checking all adjacent
  # DONE - Move that into a collection
  # DONE - Then remove from the collection anything with a "2"
  # DONE - Use the remaining collection as coordinates to check zone values
  # DONE - Push zone values into a different collection and total instances of O and X
  # DONE - compare counts of values to the rules
  # DONE - use compare results to modify the zone accordingly to O and X