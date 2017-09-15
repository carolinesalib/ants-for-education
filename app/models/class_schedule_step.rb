class ClassScheduleStep < ApplicationRecord
  belongs_to :class_schedule

  def start_at=(text)
    super(hour2min(text))
  end

  def start_at
    TimeConverter.new(super).to_s
  end

  def end_at=(text)
    super(hour2min(text))
  end

  def end_at
    TimeConverter.new(super).to_s
  end

  private

  def hour2min(text)
    TimeConverter.new(nil, text).to_min
  end
end
