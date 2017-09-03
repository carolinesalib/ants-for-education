class TeacherSchool < ApplicationRecord
  belongs_to :teacher
  belongs_to :school

  enum period: { morning: 1 , affternoon: 2, nightly: 3 }

  def course_load_humanize
    TimeConverter.min2hour(course_load)
  end

  def period_humanize
    case period
    when 'morning'
      'Matutino'
    when 'affternoon'
      'Vespertino'
    else
      'Noturno'
    end
  end
end
