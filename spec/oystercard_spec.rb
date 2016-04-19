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

  it 'deducts value from the card' do 
    expect(subject).to respond_to(:deduct).with(1).argument 
  end

  it 'deducts fare from card balance' do 
    subject.top_up(20)
    subject.deduct(10)
    expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
  end

  it 'touches in for a journey' do 
    subject.top_up(5)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'touches out to end a journey' do 
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'raises an error if the miniumum amount is not met' do 
    expect { subject.touch_in }.to raise_error 'Insufficient funds'
  end

end