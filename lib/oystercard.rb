require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_TRAVEL_BALANCE = 1

  attr_reader :balance, :journey_history, :journey

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(money)
    fail "Maximum balance of #{MAXIMUM_BALANCE} reached" if @balance + money > MAXIMUM_BALANCE
    self.balance += money
  end

  def touch_in(station)
    fail "Insufficient funds. £1 minimum needed to travel." if @balance < MINIMUM_TRAVEL_BALANCE
    if defined?(journey.ended) # checks if the journey class has been instantiated
      deduct(journey.penalty_charge) # if so, run the penalty far deduct method
    else
      @journey = Journey.new(station) # instantiates the class
      journey.start_journey # marked ended as being false
    end
  end

  def touch_out(station)
    deduct(journey.exit_charge)
    journey.end_journey(station)
    journey.clear_ended
    add_to_journey_history(station)
  end

  def add_to_journey_history(station)
    self.journey_history << {entry_station: journey.entry_station, exit_station: station}
  end

  private

  attr_writer :deduct, :balance

  def deduct(fare)
    self.balance -= fare
  end

end
