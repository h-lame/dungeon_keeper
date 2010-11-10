class EvilWizard < ActiveRecord::Base
  MAGIC_SCHOOLS = ['fire', 'chaos', 'stage']
  belongs_to :dungeon

  validates :name, :presence => true,
                   :length => {:maximum => 200},
                   :uniqueness => true

  validates :experience_points, :presence => true,
                                :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 1000, :only_integer => true}

  validates :magic_school, :presence => true,
                           :inclusion => EvilWizard::MAGIC_SCHOOLS

  validates_presence_of :dungeon
end
