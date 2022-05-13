class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
