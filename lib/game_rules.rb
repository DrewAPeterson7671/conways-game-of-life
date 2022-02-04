class GameRules
  # I am conflicted about whether this could be its own class or if it should be part of AreaScan

  def self.game_rules(scanned_values, current_zone)
    # I wanted to make a "tally_count" method for the next 3 lines, but it needs to return x_count and o_count and that seemed to be overkill for two one-line methods that both need to access value_count
    # This counts the number of instances of a distinct value
    value_count = scanned_values.tally
    # copies the count of a character to variable as an integer
    x_count = value_count["X"].to_i
    o_count = value_count["O"].to_i

    # This is the heart of the rules, evaluating the current zone and determining if the value must change
    zone_evaluation(x_count, o_count)
  end
  
  def self.zone_evaluation(x_count, o_count)
    # calls the existing value of the current zone from BoardGrid
    zone_value = ::BoardGrid.instance_variable_get(:@zone_value)
    # This copies all existing values.  All values are passing through.  The evaluation will edit only what must change.
    new_zone_value = zone_value
    
    # Guard clause seems appropriate way to deal with X.  This is the only rule to change X.  I was considering leaving the guard clause in the game_rules method, but it seemed better to make this method evaluate both O and X.
    new_zone_value = "O" if zone_value== "X" && o_count == 3
    # evaluates the O values to the rules and stores the value in 
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
    # implicit return is not sufficient on this method
    return new_zone_value
  end
end