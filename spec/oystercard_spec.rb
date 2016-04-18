require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'initializes with a balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'allows user to top up' do
    random = rand(100)
    expect { oystercard.top_up random }.to change { oystercard.balance }.by random
  end

  it 'raises an error if the maximum allowable balance is exceeded' do
    max_balance = Oystercard::MAXIMUM_BALANCE
    oystercard.top_up(max_balance)
    message = "Maximum balance of #{max_balance} exceeded"
    expect { oystercard.top_up(90) }.to raise_error message
  end
  it 'deducts the journey fare from my card' do
    oystercard.top_up(90)
    expect { oystercard.deduct(5) }.to change { oystercard.balance }.by -5
  end

end
