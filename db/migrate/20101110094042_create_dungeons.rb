class CreateDungeons < ActiveRecord::Migration
  def self.up
    create_table :dungeons do |t|
      t.string :name, :null => false, :limit => 200
      t.integer :levels, :null => false, :default => 1
    
      t.timestamps
    end

    add_index :dungeons, :name, :unique => true
  end

  def self.down
    drop_table :dungeons
  end
end
