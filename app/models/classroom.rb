class Classroom < ApplicationRecord
  has_many :classroom_disciplines

  def start_at_humanize
    start_at.strftime('%I:%M')
  end

  def stop_at_humanize
    stop_at.strftime('%I:%M')
  end

  def interval_start_humanize
    interval_start.strftime('%I:%M')
  end

  def interval_stop_humanize
    interval_stop.strftime('%I:%M')
  end
end
