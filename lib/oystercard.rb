class Oystercard
  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    message = "Maximum balance of #{MAXIMUM_BALANCE} exceeded"
    raise message if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

end
