require_relative 'journey'

class JourneyLog

  attr_reader :journey, :current_journey

  def initialize
    @journeys = []
    @current_journey = {{entry_station: nil} => {exit_station: nil}}
  end

  def start(entry_station)
    @current_journey = {{entry_station: entry_station} => {exit_station: nil}}
  end

  def finish(exit_station)
      @current_journey.values[0][:exit_station] = exit_station
      complete_journey
  end

  def complete_journey
    @journeys << current_journey
    return Journey.new.fare(complete?)
    @current_journey = {{entry_station: nil} => {exit_station: nil}}
  end

  def complete?
    current_journey.keys[0].values[0].nil? || current_journey.values[0].values[0].nil? ? false : true
  end

  def in_journey?
    !!current_journey.keys[0].values[0]
  end

  def journeys
    @journeys.dup
  end
end
