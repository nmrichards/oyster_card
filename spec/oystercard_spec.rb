require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#initialize' do

    it 'creates a new card with a balance of 0' do
      expect(oystercard.balance).to eq 0
    end

    it 'is initially not in use' do
      expect(oystercard).not_to be_in_journey
    end

  end

  it 'allows user to top up' do
    random = rand(Oystercard::MAXIMUM_BALANCE)
    expect { oystercard.top_up random }.to change { oystercard.balance }.by random
  end

  it 'raises an error if the maximum allowable balance is exceeded' do
    max_balance = Oystercard::MAXIMUM_BALANCE
    oystercard.top_up(max_balance)
    message = "Maximum balance of #{max_balance} exceeded"
    expect { oystercard.top_up(90) }.to raise_error message
  end

  describe "#touch_in" do

    it 'touches in and reports in use' do
      oystercard.top_up(20)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it 'raises an error if card doesn\'t have minimum amount' do
      expect{oystercard.touch_in}.to raise_error "Insufficient funds"
    end

  end

  describe "#touch_out" do
    before (:each) do
      oystercard.top_up(20)
      oystercard.touch_in
    end

    it 'touches out and ends journey' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts minimum fare' do
      expect{oystercard.touch_out}.to change {oystercard.balance}.by -Oystercard::MINIMUM_BALANCE
    end
  end
end
