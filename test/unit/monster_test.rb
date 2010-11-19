require 'test_helper'

class MonsterTest < ActiveRecord::TestCase
  test "should be able to create a monster with a name" do
    m = Monster.create(:name => 'Orc')
    refute m.new_record?
  end

  test "should not be able to create a monster without a name" do
    assert_no_difference('Monster.count') do
      Monster.create(:name => nil)
    end
  end
end
