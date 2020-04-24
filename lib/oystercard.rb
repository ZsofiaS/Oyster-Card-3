class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey
  
  MAX_LIMIT = 90
  MIN_LIMIT = 1
  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey = {}
    @journeys = []
    
  end

  def top_up(money)
    raise "You have exceeded the limit of #{Oystercard::MAX_LIMIT}" if @balance + money > MAX_LIMIT
    @balance += money
  end

  def touch_in(station)
    raise 'You have insufficient credit' if @balance < MIN_LIMIT
    @entry_station = station
    @journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MIN_LIMIT)
    @entry_station = nil
    @exit_station = station
    @journey[:exit_station] = station
    @journeys << @journey
  end
  
  def in_journey
    @entry_station != nil
  end

  private
  def deduct(ticket)
    @balance -= ticket
  end

end
