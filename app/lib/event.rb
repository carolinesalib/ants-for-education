class Event
  attr_accessor :lesson, :credit

  def initialize(lesson, credit)
    @lesson = lesson
    @credit = credit
  end

  def ==(other)
    @lesson.id == other.lesson.id && @credit == other.credit
  end
end