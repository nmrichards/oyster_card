require 'journeylog'

describe JourneyLog do
  let(:entry_station)   { double :entry_station }
  let(:exit_station )   { double :exit_station  }
  subject(:journeylog)  {  described_class.new  }
  it 'remembers journey history' do
    journeylog.start entry_station
    journeylog.finish exit_station
    expect(journeylog.journeys).to include(entry_station => exit_station)
  end

  it 'returns journey after completion of journey' do
    journeylog.start entry_station
    expect(journeylog.finish exit_station).to eq journeylog.journeys
  end
end
