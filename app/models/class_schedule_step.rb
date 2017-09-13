class ClassScheduleStep < ApplicationRecord
  belongs_to :class_schedule

  def start_at=(minutes)
    super(TimeConverter.hour2min(minutes))
  end

  def start_at
    TimeConverter.min2hour(super)
  end

  def end_at=(minutes)
    super(TimeConverter.hour2min(minutes))
  end

  def end_at
    TimeConverter.min2hour(super)
  end
end
