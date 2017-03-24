class Journey

  attr_reader :entry_station, :ended, :penalty_charge, :exit_charge

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station)
    @entry_station = station
    @exit_charge = nil
    @penalty_charge = 1
    @ended = nil
  end

  def start_journey
    self.ended = false
  end

  def end_journey(station)
    self.ended = true
    self
  end

  def clear_ended
    self.ended = nil
  end

  def exit_charge
    if self.ended == false
      self.exit_charge = MINIMUM_FARE
    else
      self.exit_charge = PENALTY_FARE
    end
  end

  def penalty_charge
    if self.ended == false
      self.penalty_charge = PENALTY_FARE
    else
      self.penalty_charge = 0
    end
  end

  def complete?
    ended
  end

  private

  attr_writer :ended, :fare, :penalty_charge, :exit_charge

end
