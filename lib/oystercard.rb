require_relative 'journeylog'
class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :journey_log

	def initialize(journey_log = JourneyLog.new)
		@balance = 0
    @journey_log = journey_log
	end

  def top_up(amount)
    fail "Your balance cannot exceed £#{BALANCE_LIMIT}" if (amount + balance) > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    if journey_log.in_journey?
      deduct(journey_log.finish(nil))
    end
  	fail "Insufficient funds" if @balance < MINIMUM_FARE
    journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    if journey_log.in_journey?
      deduct(journey_log.finish(exit_station))
    else
      touch_in(nil)
      deduct(journey_log.finish(exit_station))
    end
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
