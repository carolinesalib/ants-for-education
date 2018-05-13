class Problem
  attr_reader :classrooms, :days, :periods

  def initialize(classrooms, days, periods)
    @classrooms = classrooms
    @days = days
    @periods = periods
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

  def timeslot
    timeslot = []

    @classrooms.each do |classroom|
      (1..@days).each do |day|
        (1..@periods).each do |period|
          timeslot << [classroom.id, day, period]
        end
      end
    end

    timeslot
  end

  def events
    events = []

    @classrooms.each do |classroom|
      classroom.lessons.each do |lesson|
        lesson.credits.times do |credit|
          events << Credit.new(lesson, credit)
        end
      end
    end

    events
  end
end
