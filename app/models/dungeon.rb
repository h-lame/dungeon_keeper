class Dungeon < ActiveRecord::Base
  has_one :evil_wizard, :dependent => :destroy
  has_many :trap_installations
  has_many :traps, :through => :trap_installations, :uniq => true

  validates :name, :presence => true,
                   :length => {:maximum => 200},
                   :uniqueness => true

  validates :levels, :presence => true,
                     :numericality => {:greater_than_or_equal_to => 0, :only_integer => true}

  scope :without_an_evil_wizard, includes(:evil_wizard).where(:evil_wizards => {:id => nil})

  before_save :set_experience_points

  protected
  def set_experience_points
    self.experience_points = (2 ** levels)
  end
end
