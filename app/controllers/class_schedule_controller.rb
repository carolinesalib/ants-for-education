class ClassScheduleController < ApplicationController
  def edit
    @class_schedule = ClassSchedule.find(1)
  end
end
