class Oystercard

  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90
  ERR_MAX_BALANCE = "Cannot proceed - maxium balance".freeze
  ERR_MIN_BALANCE = "Insufficient funds".freeze

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
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

  def touch_out
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
  end

  private
  def deduct(fare)
    @balance -= fare
  end

end
