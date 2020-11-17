class AddUsedIdToShoppings < ActiveRecord::Migration[6.0]
  def change
    add_column :shoppings, :user_id, :integer
    add_index :shoppings, :user_id
  end
end
