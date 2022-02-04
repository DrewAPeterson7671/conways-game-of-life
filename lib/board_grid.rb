class BoardGrid

  @board_grid = { "-1, 1" => "O", "0, 1" => "X", "1, 1" => "X", 
                  "-1, 0" => "X", "0, 0" => "O", "1, 0" => "O", 
                  "-1, -1" => "O", "0, -1" => "O", "1, -1" => "X" }

  def self.generate_next_grid
    @generation_grid = Marshal.load(Marshal.dump(@board_grid))
    @generation_grid.each do |key, value|
      @zone_value = value  #passing the current zone value
      new_value = AreaScan.area_scan(key)
      # Here is where the new value replaces the old values
      @generation_grid[key] = new_value
    end
  end

end
