class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station
  attr_accessor :journeys

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @journeys = Hash.new
  end

  def top_up(amount)
    message = "Maximum balance of #{MAXIMUM_BALANCE} exceeded"
    raise message if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_BALANCE)
    @journeys[@entry_station] = station
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
