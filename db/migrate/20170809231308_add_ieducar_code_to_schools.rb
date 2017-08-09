class AddIeducarCodeToSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :ieducar_code, :integer
  end
end
