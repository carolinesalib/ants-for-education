class Event
  attr_accessor :lesson, :credit, :teacher, :timeslot

  def initialize(lesson, credit, timeslot = nil)
    @lesson = lesson
    @credit = credit
    @timeslot = timeslot
  end

  def ==(other)
    @lesson.id == other.lesson.id && @credit == other.credit
  end

  def discipline_id
    @lesson.discipline_id
  end
end