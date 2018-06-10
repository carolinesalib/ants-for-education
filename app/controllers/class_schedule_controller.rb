class ClassScheduleController < ApplicationController
  before_action :set_class_schedule, only: [:edit, :update]

  def edit
  end

  def update
    @class_schedule.update(permitted_attributes)
    redirect_to edit_class_schedule_path
  end

  private

  def set_class_schedule
    @class_schedule = ClassSchedule.find_or_create_by(id: 1)
  end

  def permitted_attributes
    params.require(:class_schedule).permit(
      class_schedule_steps_attributes: [:id, :step, :start_at, :end_at, :_destroy]
    )
  end
end
