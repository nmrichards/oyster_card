
class Journey
  attr_reader :card, :entry_station, :fares, :journeys
  MINIMUM_FARE = 1
  PENALTY = 6

  def initialize(card, *entry_station)
    @card = card
    @fares = nil
    @journeys = Hash.new
  end

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def complete?
    @entry_station != nil && @exit_station != nil ? true : false
  end

  def fare
    complete? ? @fares = MINIMUM_FARE : @fares = PENALTY
  end

  def finish(exit_station)
    @exit_station = exit_station
    fare
    @journeys = {@entry_station => exit_station}
  end

end
