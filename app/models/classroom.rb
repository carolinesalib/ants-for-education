class Classroom < ApplicationRecord
  def start_at_humanize
    start_at.strftime('%I:%M')
  end

  def stop_at_humanize
    start_at.strftime('%I:%M')
  end

  def interval_start_humanize
    start_at.strftime('%I:%M')
  end

  def interval_stop_humanize
    start_at.strftime('%I:%M')
  end
end
