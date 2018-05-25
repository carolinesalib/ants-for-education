class Problem
  attr_reader :classrooms, :days, :periods
  attr_reader :timeslots, :events
  attr_accessor :timeslots_events, :event_timeslot_pheromone

  def initialize(classrooms, days, periods, pheromone_evaporation = 0.3, minimal_pheromone = 0.0)
    @classrooms = classrooms
    @days = days
    @periods = periods
    @minimal_pheromone = minimal_pheromone
    @pheromone_evaporation = pheromone_evaporation

    calc_maximum_pheromone(pheromone_evaporation)
    initialize_timeslots
    initialize_events
    initialize_timeslots_events
  end

  def total_events
    events.size - 1
  end

  def total_timeslots
    timeslots.size - 1
  end

  def calc_maximum_pheromone(pheromone_evaporation)
    @maximum_pheromone = 9

    if pheromone_evaporation < 1.0
      @maximum_pheromone = 1.0 / (1.0 - pheromone_evaporation)
    end

    @maximum_pheromone
  end

  def total_timeslots
    @days * @periods
  end

  def valid?
    @classrooms.each do |classrooms|
      total_lessons = classrooms.lessons.map(&:credits).reduce(:+)

      raise InvalidNumberLessonsError if total_lessons != total_timeslots
    end

    true
  end

  def initialize_timeslots
    @timeslots = {}

    (1..@days).each do |day|
      (1..@periods).each do |period|
        @timeslots[[day, period]] = nil
      end
    end
  end

  def initialize_events
    @events = []

    @classrooms.each do |classroom|
      timeslot = 0
      classroom.lessons.each do |lesson|
        lesson.credits.times do |event|
          @events << Event.new(lesson, event, timeslot)
          timeslot += 1
        end
      end
    end
  end

  def initialize_timeslots_events
    @timeslots_events = []

    total_timeslots.times do |index|
      @timeslots_events[index] = []
    end
  end

  def reset_pheromone
    @event_timeslot_pheromone = {}

    total_events.times do |event_index|
      total_timeslots.times do |timeslot_index|
        @event_timeslot_pheromone[[event_index, timeslot_index]] = @maximum_pheromone
      end
    end

    @event_timeslot_pheromone
  end

  def sum_pheromone_for_event(event_index)
    total_pheromone = 0.0

    total_timeslots.times do |timeslot_index|
      total_pheromone += @event_timeslot_pheromone[[event_index, timeslot_index]]
    end

    total_pheromone
  end

  def evaporate_pheromone
    total_events.times do |event_index|
      total_timeslots.times do |timeslot_index|
        @event_timeslot_pheromone[[event_index, timeslot_index]] *= @pheromone_evaporation
      end
    end
  end

  def pheromone_min_max
    total_events.times do |event_index|
      total_timeslots.times do |timeslot_index|
        if @event_timeslot_pheromone[[event_index, timeslot_index]] < @minimal_pheromone
          @event_timeslot_pheromone[[event_index, timeslot_index]] = @minimal_pheromone
        end

        if @event_timeslot_pheromone[[event_index, timeslot_index]] > @maximum_pheromone
          @event_timeslot_pheromone[[event_index, timeslot_index]] = @maximum_pheromone
        end
      end
    end
  end
end
