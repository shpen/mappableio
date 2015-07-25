class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :title
      t.string :description
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :maps, :users
  end
end
