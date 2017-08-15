class CreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers do |t|
      t.string :ieducar_code
      t.string :name
      t.time :course_load

      t.timestamps
    end
  end
end
