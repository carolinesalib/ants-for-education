class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.references :classroom, foreign_key: true
      t.references :teacher, foreign_key: true
      t.references :class_schedule, foreign_key: true
      t.references :discipline, foreign_key: true
      t.integer :step

      t.timestamps
    end
  end
end
