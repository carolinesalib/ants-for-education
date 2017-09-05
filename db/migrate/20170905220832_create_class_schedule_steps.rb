class CreateClassScheduleSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :class_schedule_steps do |t|
      t.references :class_schedules
      t.integer :sequence
      t.time :start_at
      t.time :end_at

      t.timestamps
    end
  end
end
