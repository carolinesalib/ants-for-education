class Pheromone
  attr_accessor :event, :timeslot, :value

  def initialize(event, timeslot)
    @event = event
    @timeslot = timeslot
  end
end