class Trap < ActiveRecord::Base
  has_many :trap_installations
  has_many :dungeons, :through => :trap_installations, :uniq => true

  validates :name, :presence => true,
                   :length => {:maximum => 200},
                   :uniqueness => true

  validates :base_damage_caused, :presence => true,
                                 :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100, :only_integer => true}

end
