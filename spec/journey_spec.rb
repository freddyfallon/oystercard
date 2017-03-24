require 'journey'

describe Journey do
  let(:station) {double(:station)}
  subject(:journey) {described_class.new(station)}

  describe '#entry_station' do
    context 'when starting a journey' do
      it "it's expected to set an entry station" do
        expect(journey.entry_station).to eq station
      end

      describe '#start_journey' do
        it 'tracks a new journey' do
          journey.start_journey
          expect(journey.ended).to be false
        end
      end
    end
  end

  describe '#end_journey' do
    it 'ends the journey' do
      journey.end_journey(station)
      expect(journey.ended).to be true
    end

    it 'returns itself when exiting journey' do
      expect(journey.end_journey(station)).to eq(journey)
    end
  end

  describe '#penalty_charge' do
    it 'has a penalty charge by default' do
      journey.start_journey
      expect(journey.penalty_charge).to eq Journey::PENALTY_FARE
    end

    context 'given an entry station' do
      subject {described_class.new(entry_station: station)}
      it "returns a penalty fare if no exit station given" do
        journey.start_journey
        expect(journey.penalty_charge).to eq Journey::PENALTY_FARE
      end
    end

  end

  describe '#exit_charge' do
    context 'given an exit station' do
      let(:other_station) { double :other_station }

      it 'calculates a fare' do
        journey.start_journey
        expect(journey.exit_charge).to eq 1
      end

    end

    describe '#complete?' do
      it 'knows if a journey is not complete' do
        expect(journey).not_to be_complete
      end

      context 'given an exit station' do
        let(:other_station) { double :other_station }
      it 'knows if a journey is complete' do
        journey.start_journey
        journey.end_journey(other_station)
        expect(journey).to be_complete
      end
    end
    end
  end
end
