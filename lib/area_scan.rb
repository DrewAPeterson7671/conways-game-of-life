class AreaScan
  attr_accessor :scan_template
  
  def self.area_scan(coordinates, zone_value)
    @scan_template = [[-1, 1], [0, 1], [1, 1],
                    [-1, 0], [1, 0],
                    [-1, -1], [0, -1], [1, -1]]

    # takes the scan template and applies the coordinates of the current zone
    adjust_scan_to_current(coordinates)

    # filter_template removes all the out of bounds zones the template generated.  All out of bounds coordinates have a 2 coordinate
    filter_out_of_bounds(@scan_template)

    ## Takes the adjusted and filtered arrays of coordinates and flattens the arrays into a string that will match the keys of @board_grid to reference them
    assemble_scan_array(@filter_template)

    ### cyles through the provided coordinates around a zone and captures the current values.  It stores them in @scanned_values to be evaluated (value tally and count) by GameRules.
    scan(@scan_coordinates)

    # I am passing the zone_value through without using it.  
    # On a refactor, I would like to see if that is avoidable.
    GameRules.game_rules(@scanned_values, @current_zone, zone_value)
  end

  def self.adjust_scan_to_current(coordinates)
    @current_zone = coordinates.split(", ")
    @scan_template.each do |st| 
      st[0] = st[0] + @current_zone[0].to_i
      st[1] = st[1] + @current_zone[1].to_i
    end
  end

  def self.filter_out_of_bounds(scan_template)
    # filters out the out of bounds coordinates
    @filter_template = @scan_template.select { |a, b| a.abs != 2 && b.abs != 2 }
  end

  def self.assemble_scan_array(filter_template)
    # This puts together the filtered arrays to more easily use them to match to the board_grid keys
    @scan_coordinates = []
    @filter_template.each do |ft|
      @scan_coordinates << ft.join(", ")
    end
  end

  def self.scan(scan_coordinates)
    @scanned_values = []
    @scan_coordinates.each do |sc|
      ::BoardGrid.instance_variable_get(:@board_grid).select do |key, value| 
        @scanned_values << value if key == sc
      end
    end
  end

end
