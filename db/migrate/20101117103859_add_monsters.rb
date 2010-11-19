class AddMonsters < ActiveRecord::Migration
  def self.up
    create_table :monsters do |t|
      t.string :name, :null => false
    end
  end

  def self.down
    drop_table :monsters
  end
end
