class Timeslot
  attr_accessor :classroom_id, :day, :period

  def initialize(classroom_id, day, period)
    @classroom_id = classroom_id
    @day = day
    @period = period
  end
end