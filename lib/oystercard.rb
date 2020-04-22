class Oystercard
  attr_reader :balance, :in_journey, :station

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  def initialize
    @balance = 0
    @in_journey = false
    @station = nil
  end

  def top_up(money)
    raise "You have exceeded the limit of #{Oystercard::MAX_LIMIT}" if @balance + money > MAX_LIMIT
    @balance += money
  end

  def touch_in(station)
    raise 'You have insufficient credit' if @balance < MIN_LIMIT
    @in_journey = true
    @station = station
  end

  def touch_out
    deduct(MIN_LIMIT)
    @in_journey = false
    @station = nil
  end

  private
  def deduct(ticket)
    @balance -= ticket
  end

end
