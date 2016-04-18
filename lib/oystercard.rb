class Oystercard
  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
    @status = false
  end

  def top_up(amount)
    message = "Maximum balance of #{MAXIMUM_BALANCE} exceeded"
    raise message if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @status = true
  end

  def touch_out
    @status = false
  end

  def in_journey?
    status
  end

  private

  attr_reader :status

end
