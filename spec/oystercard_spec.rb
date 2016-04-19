require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
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

  it 'touches in for a journey' do
    subject.top_up(5)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it 'touches out to end a journey' do
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'raises an error if the miniumum amount is not met' do
    expect { subject.touch_in(station) }.to raise_error 'Insufficient funds'
  end

  it 'charges fare upon touch out' do
    subject.top_up(5)
    subject.touch_in(station)
    expect{subject.touch_out}.to change{subject.balance}.by -Oystercard::MINIMUM_BALANCE
  end

  it 'remembers which station it started from' do
    subject.top_up(5)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it 'forgets the entry station upon touch out' do
    subject.top_up(5)
    subject.touch_in(station)
    subject.touch_out
    expect(subject.entry_station).to eq nil
  end

end
