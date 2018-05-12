class NotGreatSolution
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

  def timeslot_matrix
    timeslot_matrix = []

    @classrooms.each do |classroom|
      (1..@days).each do |day|
        (1..@periods).each do |period|
          timeslot_matrix << [classroom.id, day, period]
        end
      end
    end

    timeslot_matrix
  end

  def events_matrix
    events_matrix = []

    @classrooms.each do |classroom|
      classroom.lessons.each do |lesson|
        lesson.credits.times do |credit|
          events_matrix << Credit.new(lesson, credit)
        end
      end
    end

    events_matrix
  end

  def generate
    timeslots = Array.new(timeslot_matrix.size)

    events_matrix.each_with_index do |credit, i|
      timeslots[i] = credit
    end

    timeslots
  end
end

class InvalidNumberLessonsError < StandardError; end

class Credit
  attr_accessor :lesson, :credit

  def initialize(lesson, credit)
    @lesson = lesson
    @credit = credit
  end
end