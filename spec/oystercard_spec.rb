require 'oystercard'

describe Oystercard do
  let(:station)       { double :station }
  let(:entry_station) { double :entry_station }
  let(:exit_station)  { double :exit_station}
  let(:oystercard)    { Oystercard.new }

  context 'Needs a balance'

    it 'has a balance' do
      allow(subject).to receive(:balance)
    end

    it 'has a starting balance of zero' do
      expect(subject.balance).to eq 0
    end

  context 'Needs a top up'

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

    it 'raises an error if the miniumum amount is not met' do
      expect { subject.touch_in(station) }.to raise_error 'Insufficient funds'
    end

  context 'Touches in at a station'

    it 'touches in for a journey' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

  context 'Touches out at a station'

    it 'touches out to end a journey' do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it 'charges fare upon touch out' do
      subject.top_up(5)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{subject.balance}.by -Oystercard::MINIMUM_BALANCE
    end

  context 'Logs journey history'

    it 'remembers which station it started from' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    it 'forgets the entry station upon touch out' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end

    it 'stores a list of journeys' do 
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include(entry_station => exit_station)
    end

    it 'has no journey history by default' do 
      expect(subject.journeys).to be_empty
    end

end
