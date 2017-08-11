class CreateClassrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :classrooms do |t|
      t.integer :ieducar_code
      t.string :name
      t.time :start_at
      t.time :stop_at
      t.time :interval_start
      t.time :interval_stop

      t.timestamps
    end
  end
end
