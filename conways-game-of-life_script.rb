#!/usr/bin/ruby
require ('./lib/board_grid.rb')
require ('./lib/area_scan.rb')
require ('./lib/game_rules.rb')

def big_spacer
  6.times { puts "" }
end

def spacer
  3.times { puts "" }
end

#rudimentary UI
system("clear")

big_spacer()

puts "\t\tGen 0\n"
puts ""

BoardGrid.display_board_grid

spacer()

puts "\t\tGen 1\n"
puts ""

BoardGrid.generate_next_grid
BoardGrid.display_generation_grid

big_spacer()
