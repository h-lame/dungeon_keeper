require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "actions_menu should wrap each argument in a <li> inside a single <ul> with the class 'actions'" do
    render :text => actions_menu('whatever', 'i', 'want')
    assert_select '.actions_menu' do
      assert_select '.action:first-child', :text => 'whatever'
      assert_select '.action', :text => 'i'
      assert_select '.action:last-child', :text => 'want'
    end
  end

  test "actions_menu should output nothing if no arguments are supplied" do
    assert actions_menu.blank?
  end

  test "yes_or_no should return 'yes' if the supplied argument is truthy" do
    [true, '', :a_thing].each do |truthy_value|
      assert_equal 'yes', yes_or_no(truthy_value)
    end
  end

  test "yes_or_no should return 'no' if the supplied argument is falsy" do
    [false, nil].each do |falsy_value|
      assert_equal 'no', yes_or_no(falsy_value)
    end
  end
end
