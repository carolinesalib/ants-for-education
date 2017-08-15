class TeacherSchool < ApplicationRecord
  belongs_to :teacher

  def course_load_humanize
    course_load.strftime('%I:%M')
  end
end
