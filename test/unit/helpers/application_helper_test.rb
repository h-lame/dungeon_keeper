require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "actions_menu should wrap each argument in a <li> inside a single <ul> with the class 'actions'" do
    render :text => actions_menu('whatever', 'i', 'want')
    assert_select 'ul.actions' do
      assert_select 'li', :text => 'whatever'
      assert_select 'li', :text => 'i'
      assert_select 'li', :text => 'want'
    end
  end

  test "actions_menu should output nothing if no arguments are supplied" do
    assert actions_menu.blank?
  end
end
