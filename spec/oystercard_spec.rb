require 'oystercard'

describe Oystercard do 

  let(:oystercard) { Oystercard.new }

  it 'has a balance' do 
    allow(subject).to receive(:balance)
  end

  it 'has a starting balance of zero' do 
    expect(subject.balance).to eq 0
  end

  it 'can be topped up' do 
    expect(subject).to respond_to(:top_up).with(1).argument 
  end

  it 'adds to card balance' do 
    subject.top_up(50)
    expect(subject.balance).to eq 50
  end

  it 'raises an error if the maximum balance is reached' do 
    maximum = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum)
    expect { subject.top_up 10 }.to raise_error Oystercard::ERR_MAX_BALANCE
  end

end