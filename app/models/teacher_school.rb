class TeacherSchool < ApplicationRecord
  belongs_to :teacher

  enum period: { morning: 1 , affternoon: 2, nightly: 3 }

  def course_load_humanize
    TimeConverter.min2hour(course_load)
  end
end
