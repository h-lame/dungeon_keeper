class Trap < ActiveRecord::Base
  validates :name, :presence => true,
                   :length => {:maximum => 200},
                   :uniqueness => true

  validates :base_damage_caused, :presence => true,
                                 :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100, :only_integer => true}

end
