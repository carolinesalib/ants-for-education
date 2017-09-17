class Serie < ApplicationRecord
  def course_load
    TimeConverter.new(super).to_s
  end
end
