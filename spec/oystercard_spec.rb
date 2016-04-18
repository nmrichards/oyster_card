require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it "initializes with a balance of 0" do
    expect(oystercard.balance).to eq 0
  end

  it "allows user to top up" do
    random = rand(100)
    expect { oystercard.top_up random }.to change { oystercard.balance }.by random
  end

end
