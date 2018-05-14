class Event
  attr_accessor :lesson, :credit

  def initialize(lesson, credit)
    @lesson = lesson
    @credit = credit
  end
end