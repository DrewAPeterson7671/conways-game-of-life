class BoardGrid
  attr_reader :board_grid

  @board_grid = { "-1, 1" => "O", "0, 1" => "X", "1, 1" => "X", 
                  "-1, 0" => "X", "0, 0" => "O", "1, 0" => "O", 
                  "-1, -1" => "O", "0, -1" => "O", "1, -1" => "X" }

  def self.generate_next_grid
    # This was an instance variable

    # I'd prefer not to destructively alter the original @board_grid for visual verfication
    # I don't like using "gen1_grid" as a name, wanted to make it flexible for multiple generation uses
    # This method seems to be the best place to drive the overall script.
    @generation_grid = Marshal.load(Marshal.dump(@board_grid))
    @generation_grid.each do |key, value|
      new_value = AreaScan.area_scan(key, value)
      # Here is where the new value replaces the old values
      @generation_grid[key] = new_value
    end
  end
  
  def self.display_grid(grid_name)

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

  def self.display_board_grid
    display_grid(@board_grid)
  end

  def self.display_generation_grid
    display_grid(@generation_grid)
  end  

end