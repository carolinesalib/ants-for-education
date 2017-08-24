class Serie < ApplicationRecord
  def course_load_humanize
    TimeConverter.min2hour(course_load)
  end
end
