class CreateClassScheduleSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :class_schedule_steps do |t|
      t.references :class_schedule, foreign_key: true
      t.integer :sequence
      t.integer :start_at
      t.integer :end_at

      t.timestamps
    end
  end
end
