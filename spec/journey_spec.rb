# require 'journey'
#
# describe Journey do
#   let(:oystercard){ double :oystercard, touch_in: nil, touch_out: nil, deduct: nil }
#   let(:entry_station)   { double :entry_station }
#   let(:exit_station )   { double :exit_station  }
#   subject(:journey){described_class.new oystercard}
#
#   it 'starts a journey' do
#     expect(journey.start_journey entry_station).to eq entry_station
#   end
#
#   it 'ends a journey' do
#     journey.start_journey entry_station
#     journey.finish exit_station
#     expect(journey.complete?).to eq true
#   end
#
#   context 'paying for journey' do
#     it 'takes off the minimum fare'do
#       journey.start_journey entry_station
#       journey.finish exit_station
#       expect(journey.fare).to eq journey.fares
#     end
#   end
#
#   it 'completes a journey' do
#     journey.start_journey entry_station
#     journey.finish exit_station
#     expect(journey).to be_complete
#   end
#
#   it 'ensures journey isn\'t complete' do
#     journey.start_journey entry_station
#     expect(journey).not_to be_complete
#   end
#
#   it 'charges a penalty' do
#     journey.start_journey entry_station
#     journey.fare
#     expect(journey.fares).to be 6
#   end
#
#   it 'returns the journey when exiting the journey' do
#     journey.start_journey entry_station
#     expect(journey.finish exit_station).to eq journey.journeys
#   end
#
# end
