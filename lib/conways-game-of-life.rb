

# lets display the grid first and see how that looks
# remember that the off-by-one error is a factor here

board_grid = [["O","X","X"], ["X","O","O"], ["O","O","X"]]

new_board_grid = {1 => [-1, 1, "O"], 2 => [0, 1, "X"], 3 => [1, 1, "X"], 4 => [-1, 0, "X"], 5 => [0, 0, "O"], 6 => [1, 0, "O"], 7 => [-1, -1, "O"], 8 => [0, -1, "O"], 9 => [1, -1, "X"]}

top_row = ""
mid_row = ""
bottom_row = ""

def generate_next_gen(grid)
  # I'd prefer not to destructively alter the original board_grid
  # I don't like using "gen1_grid" as a name, wanted to make it flexible for multiple generation uses
  @gen1_grid = Marshal.load(Marshal.dump(grid))
  @gen1_grid.each do |g1|
    # g1.map do |i|
      puts g1 # check neighbors if 1st zone
      # if method = true : change status
      # Another way to look at it is O is baseline?
    # end
    
    
    
  end
  # puts ""
  # puts @gen1_grid
  # puts ""
end

def corner_scan(orientation)
  # ok, shift zero to center
  # Then remove any "2"
  # should be a hash so the key can be a -1

  9.times do |i|
    neighbor_check = new_board_grid[i].map do |nc|
      grab x and y of nc
      do the math blindly and shove in array
        screen out any "2" results
        loop through new array matching x to nc[i][0] 
          then matching "y"  get the nc[i][2] value
          shove that value into array
          count instances
          apply rules
          change or no change

      

  # upper_left = [1, 0], [1, -1], [0, -1]
  # upper_right = upper_left.each { |ur| ur[0] = ur[0] * -1}
  # puts upper_right


  # upper_right = upper_left.each do |ur| { ur[0].to_i() * -1 }
  # upper_right = upper_left.each { |ur| puts ur }

  # board_grid
  
  # upper left
  # x +1, y 0
  # x +1, y -1
  # x 0 y -1

  # upper right x * -1

  # x -1, y 0
  # x -1, y -1
  # x 0, y -1




  #disposition handled here?
  # should output CHANGE STATUS true or false
  # check cell current state, if O or X
  # O must have exactly 2-3 O neighbors OR x
  # X with 4+ O neighbors TO O
  # Another way to look at it is O is baseline?
  @count.count # should total up the Os

end

def corner_scan(orientation)

end

def center_edge_scan(orientation)

end




#rudimentary UI

system("clear")

6.times { puts "" }

puts "\t\tGen 0\n"
puts ""

board_grid.each do |bg|
    puts "\t\t" + bg.join(' ')
end

3.times { puts "" }

puts "\t\tGen 1\n"
puts ""

generate_next_gen(board_grid)

@gen1_grid.each do |gg|
    puts "\t\t" + gg.join(' ')
end

3.times { puts "" }
puts "HASH grid"
puts ""

(1..3).each do |i|
  top_row += "#{new_board_grid[i][2]} "
end
puts top_row

(4..6).each do |i|
  mid_row += "#{new_board_grid[i][2]} "
end
puts mid_row

(7..9).each do |i|
  bottom_row += "#{new_board_grid[i][2]} "
end
puts bottom_row



6.times { puts "" }


# 9.times do |i|
#   neighbor_check = new_board_grid[i].map do |nc|
#     grab x and y of nc
#     do the math blindly and shove in array
#       screen out any "2" results
#       loop through new array matching x to nc[i][0] 
#         then matching "y"  get the nc[i][2] value
#         shove that value into array
#         count instances
#         apply rules
#         change or no change