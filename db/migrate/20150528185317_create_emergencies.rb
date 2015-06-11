class CreateEmergencies < ActiveRecord::Migration
  def change
    create_table :emergencies, id: false do |t|
      t.string :code, primary_key: true
      t.integer :fire_severity
      t.integer :police_severity
      t.integer :medical_severity
    end

    add_index :emergencies, :code, unique: true
  end
end
