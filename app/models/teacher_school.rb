class TeacherSchool < ApplicationRecord
  belongs_to :teacher
  belongs_to :school

  enum period: { morning: 1 , affternoon: 2, nightly: 3 }

  def course_load
    TimeConverter.new(super).to_s
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
