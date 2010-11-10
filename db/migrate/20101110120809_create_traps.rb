class CreateTraps < ActiveRecord::Migration
  def self.up
    create_table :traps do |t|
      t.string :name, :null => false, :limit => 200
      t.integer :base_damage_caused, :null => false, :default => 1

      t.timestamps
    end

    add_index :traps, :name, :unique => true
  end

  def self.down
    drop_table :traps
  end
end
