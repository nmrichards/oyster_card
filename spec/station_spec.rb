require 'station'

describe Station do 

  let(:station)    { Station.new('London', 'Zone 1')}

  it 'should have a location' do 
    expect(station.location).to eq 'London' 
  end

  it 'should have a zone' do 
    expect(station.zone).to eq 'Zone 1'
  end
  
end


