class Oystercard

  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90
  ERR_MAX_BALANCE = "Cannot proceed - maxium balance".freeze
  ERR_MIN_BALANCE = "Insufficient funds".freeze
  
  attr_reader :balance

  def initialize 
    @balance = 0
    @status = false
  end

  def top_up(amount)
    fail ERR_MAX_BALANCE if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    fail ERR_MIN_BALANCE if @balance < MINIMUM_BALANCE
    in_journey?
    @status = true
  end

  def in_journey? 
    @status 
  end

  def touch_out
    @status = false
  end

end