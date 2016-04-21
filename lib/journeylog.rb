require_relative 'journey'

class JourneyLog
  attr_reader :journeys

  def initialize(journey = Journey.new(self))
    @journey = journey
    @journeys = []
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    @journeys << { @entry_station => exit_station }
  end

  def complete?
    @entry_station != nil && @exit_station != nil ? true : false
  end

  private

  def current_journey

  end
end
