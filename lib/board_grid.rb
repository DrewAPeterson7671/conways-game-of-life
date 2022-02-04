class BoardGrid

  @board_grid = { "-1, 1" => "O", "0, 1" => "X", "1, 1" => "X", 
                  "-1, 0" => "X", "0, 0" => "O", "1, 0" => "O", 
                  "-1, -1" => "O", "0, -1" => "O", "1, -1" => "X" }

  def self.generate_next_grid
    # I keep thinking there is a better way to make a deep copy
    @generation_grid = Marshal.load(Marshal.dump(@board_grid))
    # This block below drives the whole script forward by starting the evaluation of each zone
    @generation_grid.each do |key, value|
      # sets aside the value of the current zone for the GameRules to evalute
      @zone_value = value
      # kicks off the process of checking the surrounding neighbors of each zone
      new_value = AreaScan.area_scan(key)
      # Here is where the new value replaces the old value if the evaluation of the rules requires it
      @generation_grid[key] = new_value
    end
  end

end
