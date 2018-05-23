class Event
  attr_accessor :lesson, :credit, :teacher, :timeslot

  def initialize(lesson, credit)
    @lesson = lesson
    @credit = credit
  end

  def ==(other)
    @lesson.id == other.lesson.id && @credit == other.credit
  end

  def discipline_id
    @lesson.discipline_id
  end
end