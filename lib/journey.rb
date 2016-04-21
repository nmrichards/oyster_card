class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def fare(complete)
    complete ? MINIMUM_FARE : PENALTY_FARE
  end

end
