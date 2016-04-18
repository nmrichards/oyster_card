class Oystercard

  MAXIMUM_BALANCE = 90
  ERR_MAX_BALANCE = "Cannot proceed - maxium balance".freeze
  attr_reader :balance

  def initialize 
    @balance = 0
  end

  def top_up(amount)
    fail ERR_MAX_BALANCE if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

end