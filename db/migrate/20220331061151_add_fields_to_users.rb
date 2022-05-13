class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :pro, :boolean, default: false
  end
end
