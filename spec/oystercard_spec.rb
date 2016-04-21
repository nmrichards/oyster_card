require 'oystercard'

describe Oystercard do
  subject(:oystercard)  { described_class.new }
  let(:entry_station)   { double :station }
  let(:exit_station)    { double :station }

  describe '#initialize' do
    it 'creates a new card with a balance of 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  it 'allows user to top up' do
    random = rand(Oystercard::BALANCE_LIMIT)
    expect { oystercard.top_up random }.to change { oystercard.balance }.by random
  end

  it 'raises an error if the maximum allowable balance is exceeded' do
    max_balance = Oystercard::BALANCE_LIMIT
    oystercard.top_up(max_balance)
    message = "Your balance cannot exceed £#{max_balance}"
    expect { oystercard.top_up(90) }.to raise_error message
  end

  describe "#touch_in" do
    context 'needs a top up and touch in' do
      before (:each) do
        oystercard.top_up(20)
        oystercard.touch_in(entry_station)
      end
    end

    context 'doesn\'t need to be topped off' do
      it 'raises an error if card doesn\'t have minimum amount' do
        expect{oystercard.touch_in(entry_station)}.to raise_error "Insufficient funds"
      end
    end
  end

  describe '#touch_out' do
    before (:each) do
      oystercard.top_up(20)
    end
    it 'deducts penalty fare' do
      expect{oystercard.touch_out(exit_station)}.to change {oystercard.balance}.by -6
    end

    it 'deducts minimum fare' do
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_out(exit_station)}.to change {oystercard.balance}.by -Oystercard::MINIMUM_FARE
    end
  end

end
