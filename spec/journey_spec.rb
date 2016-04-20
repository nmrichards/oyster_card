require 'journey'

describe Journey do
  let(:oystercard){ double :oystercard, touch_in: nil, touch_out: nil, deduct: nil }
  let(:entry_station)   { double :entry_station }
  let(:exit_station )   { double :exit_station  }
  subject(:journey){described_class.new oystercard}
  it{is_expected.to respond_to :start_journey}
  it{is_expected.to respond_to :end_journey}

  it 'starts a journey' do
    expect(journey.start_journey entry_station).to eq entry_station
  end

  it 'ends a journey' do
    journey.start_journey entry_station
    expect(journey.end_journey exit_station).to eq exit_station
  end

  context 'paying for journey' do
    it 'takes off the minimum fare'do
      journey.start_journey entry_station
      journey.end_journey exit_station
      expect(journey.fare).to eq journey.fares
    end
  end

  it 'completes a journey' do
    journey.start_journey entry_station
    journey.end_journey exit_station
    expect(journey).to be_complete
  end

  it 'ensures journey isn\'t complete' do
    journey.start_journey entry_station
    expect(journey).not_to be_complete
  end

  it 'charges a penalty' do
    journey.start_journey entry_station
    journey.fare
    expect(journey.fares).to be 6
  end

  it 'returns the journey when exiting the journey' do
    journey.start_journey entry_station
    expect(journey.finish exit_station).to eq journey.journeys
  end

end
