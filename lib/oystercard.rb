class Oystercard

  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90
  ERR_MAX_BALANCE = "Cannot proceed - maxium balance".freeze
  ERR_MIN_BALANCE = "Insufficient funds".freeze

  attr_reader :balance, :entry_station, :exit_station
  attr_accessor :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = Hash.new
  end

  def top_up(amount)
    fail ERR_MAX_BALANCE if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail ERR_MIN_BALANCE if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def in_journey?
    !!@entry_station
  end

  def touch_out(station)
    deduct(MINIMUM_BALANCE)
    @journeys[@entry_station] = station
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end