require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station
  attr_accessor :journeys

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    message = "Maximum balance of #{MAXIMUM_BALANCE} exceeded"
    raise message if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_BALANCE
    @entry_station = station
    @journey = Journey.new self
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journeys << @journey.finish(station)
    deduct(@journey.fares)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def deduct(amount)
    @balance -= amount
  end

end
