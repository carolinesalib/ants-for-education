class ClassroomDiscipline < ApplicationRecord
  belongs_to :classroom
  belongs_to :discipline

  def course_load_humanize
    course_load.strftime('%I:%M') if course_load
  end
end
