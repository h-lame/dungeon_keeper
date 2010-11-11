module TrapInstallationsHelper
  def scoped_parent_for_title
    %Q{#{of_or_in_based_on_scope} #{dungeon_or_trap_based_on_scope}: #{link_to_dungeon_or_trap_based_on_scope}}.html_safe
  end

  def of_or_in_based_on_scope
    case @scope
    when Trap
      'of'
    when Dungeon
      'in'
    end
  end

  def dungeon_or_trap_based_on_scope
    @scope.class.name.titleize
  end

  def dungeon_or_trap_inverse_of_scope
    case @scope
    when Trap
      'Dungeon'
    when Dungeon
      'Trap'
    end
  end

  def link_to_dungeon_or_trap_based_on_scope
    link_to @scope.name, @scope
  end

  def link_to_dungeon_or_trap_inverse_of_scope(for_trap_installation)
    case @scope
    when Trap
      link_to for_trap_installation.dungeon.name, for_trap_installation.dungeon
    when Dungeon
      link_to for_trap_installation.trap.name, for_trap_installation.trap
    end
  end

  def description_of_trap_installation(for_trap_installation)
    %Q{#{link_to for_trap_installation.trap.name, for_trap_installation.trap} on level #{for_trap_installation.level} of #{link_to for_trap_installation.dungeon.name, for_trap_installation.dungeon}}.html_safe
  end
end
