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
      new_value = neighbor_scan(key, value)
      # Here is where the new value replaces the old values
      @generation_grid[key] = new_value
    end
  end

end