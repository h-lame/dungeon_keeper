require 'test_helper'

class TrapTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_most(200)
  should validate_uniqueness_of(:name)

  should validate_presence_of(:base_damage_caused)
  should ensure_inclusion_of(:base_damage_caused).in_range(0..100).with_high_message(default_error_message(:less_than_or_equal_to, :count => 100))

  should have_many(:dungeons).through(:trap_installations)
  should "not list a dungeon twice if this trap has been installed there more than once" do
    t = Trap.create(:name => 'Fire Pit', :base_damage_caused => 80)
    t.trap_installations.create(:dungeon => dungeons(:one), :level => 1, :size => 'normal')
    t.trap_installations.create(:dungeon => dungeons(:one), :level => 7, :size => 'slightly ridiculous')

    assert_equal 1, t.dungeons.size
    assert t.dungeons.include?(dungeons(:one))
  end
end
