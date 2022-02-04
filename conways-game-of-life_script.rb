#!/usr/bin/ruby
require ('./lib/board_grid.rb')
require ('./lib/area_scan.rb')
require ('./lib/game_rules.rb')

def spacer
  3.times { puts "" }
end

def display_grid(grid_name)
  top_row = ""; mid_row = ""; bottom_row = ""
  
  grid_name.each_with_index do |(key, value), i|
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
end


#rudimentary UI
system("clear")

spacer()

puts "\t\tGen 0\n"
puts ""

display_grid(::BoardGrid.instance_variable_get(:@board_grid))

spacer()

puts "\t\tGen 1\n"
puts ""

BoardGrid.generate_next_grid
display_grid(::BoardGrid.instance_variable_get(:@generation_grid))

spacer()
