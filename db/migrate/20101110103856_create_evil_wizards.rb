class CreateEvilWizards < ActiveRecord::Migration
  def self.up
    create_table :evil_wizards do |t|
      t.string :name, :null => false, :limit => 200
      t.integer :experience_points, :null => false, :default => 1
      t.string :magic_school, :null => false
      t.belongs_to :dungeon, :null => false

      t.timestamps
    end
    
    add_index :evil_wizards, :name, :unique => true
  end

  def self.down
    drop_table :evil_wizards
  end
end
