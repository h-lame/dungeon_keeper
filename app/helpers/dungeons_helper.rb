module DungeonsHelper
  def show_evil_wizard_for_dungeon(for_dungeon)
    if for_dungeon.evil_wizard.present?
      link_to for_dungeon.evil_wizard.name, for_dungeon.evil_wizard
    else
      %Q{No evil wizard in this dungeon, #{link_to 'why not add one?', new_evil_wizard_path}}.html_safe
    end
  end
end
