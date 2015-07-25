class CreateMapUsers < ActiveRecord::Migration
  def change
    create_table :map_users do |t|
      t.references :map, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :map_users, :maps
    add_foreign_key :map_users, :users
  end
end
