class TrapInstallation < ActiveRecord::Base
  DAMAGE_MODIFIER_PROCS = {
    'small' => lambda { |base_damage| base_damage * 0.5 },
    'normal' => lambda { |base_damage| base_damage },
    'big' => lambda { |base_damage| base_damage * 2 },
    'slightly ridiculous' => lambda { |base_damage| base_damage * base_damage }
  }
  SIZES = DAMAGE_MODIFIER_PROCS.keys
  belongs_to :dungeon
  belongs_to :trap

  validates_presence_of :dungeon, :trap

  validates :level, :presence => true,
                    :numericality => {:only_integer => true,
                                      :greater_than => 0,
                                      :less_than_or_equal_to => :maximum_possible_level_for_installation}

  validates :size, :presence => true,
                   :inclusion => TrapInstallation::SIZES

  def maximum_possible_level_for_installation
    if dungeon.present?
      dungeon.levels
    else
      1
    end
  end

  def damage_caused
    return 0 if fake? || trap.nil?

    base_damage = trap.base_damage_caused * level
    modifier_proc = DAMAGE_MODIFIER_PROCS[size]
    if modifier_proc.nil?
      base_damage
    else
      modifier_proc.call(base_damage)
    end
  end

  def description
    %Q{#{trap.name} on level #{level} of #{dungeon.name}}
  end
end