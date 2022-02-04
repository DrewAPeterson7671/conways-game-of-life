class AreaScan

  def self.area_scan(coordinates, zone_value)
    scan_template = [[-1, 1], [0, 1], [1, 1],
                    [-1, 0], [1, 0],
                    [-1, -1], [0, -1], [1, -1]]
    scan_coordinates = []
    scanned_values = []


    current_zone = coordinates.split(", ")  
    # takes the argument for the zone we are currently in
    scan_template.each do |st| 
      # the scan_template checks each zone of the perimeter from 0,0.  
      # This block adds the current coordinates to the scan template coordinates 
      # to scan each zone for 360, regardless if that is out of bounds
      # On a refactor, It seems there might be a way eliminated out-of-bounds values here
      st[0] = st[0] + current_zone[0].to_i
      st[1] = st[1] + current_zone[1].to_i
    end
    # filter_template removes all the out of bounds zones the template generated
    filter_template = scan_template.select { |a, b| a.abs != 2 && b.abs != 2 }
    # This puts together the arrays to more easily use them to match to the board_grid keys
    filter_template.each do |ft|
      scan_coordinates << ft.join(", ")
    end
    # This block finds the values surrounding each zone one at a time
    # It stores all the values in the scanned_values array
    scan_coordinates.each do |sc|
      ::BoardGrid.instance_variable_get(:@board_grid).select do |key, value| 
        scanned_values << value if key == sc
      end
    end
    # I am passing the zone_value through without using it.  
    # On a refactor, I would like to see if that is avoidable.
    GameRules.game_rules(scanned_values, current_zone, zone_value)
  end

end