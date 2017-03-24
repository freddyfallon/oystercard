require 'journeylog'

describe JourneyLog do

  describe '#journeys' do
    it { is_expected.to respond_to(:journeys) }
  end

  describe '#current_journey' do
    it 'is expected to respond to current_journey' do
      expect(subject).to respond_to(:current_journey)
    end
  end

end
