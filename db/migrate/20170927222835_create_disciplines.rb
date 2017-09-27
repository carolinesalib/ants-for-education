class CreateDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :disciplines do |t|
      t.string :name
      t.integer :ieducar_code

      t.timestamps
    end
  end
end
