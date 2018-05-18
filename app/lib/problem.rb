class Problem
  attr_reader :classrooms, :days, :periods
  attr_reader :timeslots, :events
  attr_accessor :timeslots_events, :event_timeslot_pheromone

  PHEROMONE_EVAPORATION = 1.0

  def initialize(classrooms, days, periods)
    @classrooms = classrooms
    @days = days
    @periods = periods

    initialize_timeslots
    initialize_events
    initialize_timeslots_events
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
      classroom.lessons.each do |lesson|
        lesson.credits.times do |event|
          @events << Event.new(lesson, event)
        end
      end
    end
  end

  def initialize_timeslots_events
    @timeslots_events = []

    timeslots.size.times do |index|
      @timeslots_events[index] = []
    end
  end

  def reset_pheromone
    t_max = 3.3 # calc after
    @event_timeslot_pheromone = {}

    events.size.times do |event_index|
      timeslots.size.times do |timeslot_index|
        @event_timeslot_pheromone[[event_index, timeslot_index]] = t_max
      end
    end

    @event_timeslot_pheromone
  end

  def sum_pheromone_for_event(event_index)
    total_pheromone = 0.0

    timeslots.size.times do |timeslot_index|
      total_pheromone += @event_timeslot_pheromone[[event_index, timeslot_index]]
    end

    total_pheromone
  end

  def evaporate_pheromone
    events.size.times do |event_index|
      timeslots.size.times do |timeslot_index|
        @event_timeslot_pheromone[[event_index, timeslot_index]] *= PHEROMONE_EVAPORATION
      end
    end
  end
end
