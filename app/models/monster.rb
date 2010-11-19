class Monster < ActiveRecord::Base
  validates :name, :presence => true
end