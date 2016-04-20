require 'station'

describe Station do
  subject(:station){described_class.new( location: 'London', zone: 1 )}
  describe '#initialize' do

    it 'stores a location' do
        expect(station.location).to eq "London"
    end

    it 'stores a zone' do
      expect(station.zone).to eq 1
    end

  end

end
