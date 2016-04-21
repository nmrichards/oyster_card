require 'journey'

describe Journey do
  subject(:journey){described_class.new}

  it 'takes off the minimum fare'do
    expect(journey.fare(true)).to eq Journey::MINIMUM_FARE
  end

  it 'charges a penalty' do
    expect(journey.fare(false)).to be Journey::PENALTY_FARE
  end
end
