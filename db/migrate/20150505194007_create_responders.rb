class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders, id: false do |t|
      t.string :type
      t.string :name, primary_key: true
      t.integer :capacity
    end

    add_index :responders, :name, unique: true
  end
end
