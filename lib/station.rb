class Station
  attr_reader :location, :zone

  def initialize(location_zone = {})
    @location = location_zone[:location]
    @zone = location_zone[:zone]
  end

end
