module ApplicationHelper
  def actions_menu(*actions)
    if actions.any?
      content_tag(:ul, :class => 'actions') do
        actions.map { |a| content_tag(:li, a) }.join("\n")
      end
    end
  end
end
