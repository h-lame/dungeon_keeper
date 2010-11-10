class Dungeon < ActiveRecord::Base
  has_one :evil_wizard, :dependent => :destroy

  validates :name, :presence => true,
                   :length => {:maximum => 200},
                   :uniqueness => true

  validates :levels, :presence => true,
                     :numericality => {:greater_than_or_equal_to => 0, :only_integer => true}

end