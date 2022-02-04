class GameRules

  def self.game_rules(scanned_values, current_zone)
    zone_value = ::BoardGrid.instance_variable_get(:@zone_value)
    # This value_count seems inefficient.  I would need to research options.
    value_count = scanned_values.tally
    x_count = value_count["X"].to_i
    o_count = value_count["O"].to_i
    # It seems simplest to transfer all current values and pass through all unchanged
    new_zone_value = zone_value
    # Guard clause seems appropriate way to deal with X.  This is the only rule
    # that would change X
    new_zone_value = "O" if zone_value== "X" && o_count == 3
    if zone_value== "O"
      case o_count
      when 1
        new_zone_value = "X"
      when 2..3
        new_zone_value
      when 4..8
        new_zone_value = "X"
      else puts " ERROR "
      end
    end
    return new_zone_value
  end

end