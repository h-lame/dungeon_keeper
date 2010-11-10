class CreateTrapInstallations < ActiveRecord::Migration
  def self.up
    create_table :trap_installations do |t|
      t.integer :dungeon_id, :null => false
      t.integer :trap_id, :null => false
      t.integer :level, :null => false, :default => 1
      t.string :size, :null => false
      t.boolean :fake, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :trap_installations
  end
end
