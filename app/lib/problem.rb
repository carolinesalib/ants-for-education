class Problem
  attr_reader :classrooms, :days, :periods, :event_timeslot_pheromone

  def initialize(classrooms, days, periods)
    @classrooms = classrooms
    @days = days
    @periods = periods

    initialize_event_timeslot_pheromone
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

  def timeslots
    timeslot = []

    @classrooms.each do |classroom|
      (1..@days).each do |day|
        (1..@periods).each do |period|
          timeslot << Timeslot.new(classroom.id, day, period)
        end
      end
    end

    timeslot
  end

  def events
    events = []

    @classrooms.each do |classroom|
      classroom.lessons.each do |lesson|
        lesson.credits.times do |event|
          events << Event.new(lesson, event)
        end
      end
    end

    events
  end

  # TODO: move this code to a class named pheromone
  def initialize_event_timeslot_pheromone
    t_max = 3.3 # calc after
    @event_timeslot_pheromone = []

    events.each do |event|
      timeslots.each do |timeslot|
        pheromone = Pheromone.new(event, timeslot)
        pheromone.value = t_max
        @event_timeslot_pheromone << pheromone
      end
    end

    @event_timeslot_pheromone
  end

  def sum_pheromone_for_event(event)
    @event_timeslot_pheromone.select { |pheromone| pheromone.event == event }.map(&:value).reduce(:+)
  end
end
