class FixColumnNameOnScheduleStepsTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :class_schedule_steps, :sequence, :step
  end
end
