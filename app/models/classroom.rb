class Classroom < ApplicationRecord
  has_many :lessons
  has_many :disciplines, through: :lessons
  belongs_to :serie
  belongs_to :course
  belongs_to :school

  def start_at_humanize
    start_at.strftime('%I:%M') if start_at
  end

  def stop_at_humanize
    stop_at.strftime('%I:%M') if stop_at
  end

  def interval_start_humanize
    interval_start.strftime('%I:%M') if interval_start
  end

  def interval_stop_humanize
    interval_stop.strftime('%I:%M') if interval_stop
  end

  def self.filter(school_id, course_id, serie_id)
    Classroom.where(school_id: school_id, course_id: course_id, serie_id: serie_id)
  end
end
