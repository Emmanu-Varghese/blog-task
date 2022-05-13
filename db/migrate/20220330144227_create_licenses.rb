class CreateLicenses < ActiveRecord::Migration[7.0]
  def change
    create_table :licenses do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
