
class Journey
  attr_reader :fares
  MINIMUM_FARE = 1
  PENALTY = 6

  def initialize(log)
    @log.log
    @fares = nil
  end

  def fare
    @log.complete? ? @fares = MINIMUM_FARE : @fares = PENALTY
  end

  # def start_journey(entry_station)
  #   @entry_station = entry_station
  # end
  #
  # def complete?
  #   @entry_station != nil && @exit_station != nil ? true : false
  # end


  #
  # def finish(exit_station)
  #   @exit_station = exit_station
  #   fare
  #   @journeys = {@entry_station => exit_station}
  # end

end
