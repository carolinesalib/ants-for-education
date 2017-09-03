class Teacher < ApplicationRecord
  has_many :teacher_disciplines
  has_many :teacher_schools

  def course_load_humanize
    TimeConverter.min2hour(course_load)
  end
end
