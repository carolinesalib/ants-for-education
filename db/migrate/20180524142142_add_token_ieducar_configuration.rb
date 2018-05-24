class AddTokenIeducarConfiguration < ActiveRecord::Migration[5.0]
  def change
    add_column :ieducar_configurations, :token, :string
  end
end
