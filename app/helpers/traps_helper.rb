module TrapsHelper
  def dungeons_a_trap_is_installed_in(for_trap)
    if for_trap.dungeons.any?
      for_trap.dungeons.map {|d| link_to d.name, d }.to_sentence
    else
      %Q{None! Why not #{link_to 'install it in one', new_trap_trap_installation_path(for_trap)}}.html_safe
    end
  end
end
