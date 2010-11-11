class AddExperiencePointsToDungeons < ActiveRecord::Migration
  def self.up
    change_table :dungeons do |t|
      t.integer :experience_points, :null => false, :default => 0
    end
  end

  def self.down
    remove_column :dungeons, :experience_points
  end
end
