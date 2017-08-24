class CreateSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.integer :ieducar_code
      t.string :name
      t.integer :course_load
      t.integer :school_days
      t.integer :interval

      t.timestamps
    end
  end
end
