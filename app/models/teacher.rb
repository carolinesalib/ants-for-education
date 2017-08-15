class Teacher < ApplicationRecord
  has_many :teacher_disciplines
  has_many :teacher_schools

  def course_load_humanize
    course_load.strftime('%I:%M')
  end
end
