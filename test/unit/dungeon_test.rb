require 'test_helper'

class DungeonTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_most(200)
  should validate_uniqueness_of(:name)

  should validate_presence_of(:levels)
  should validate_numericality_of(:levels)

  should "require a the count of levels to be more than 0" do
    d = Dungeon.new
    d.levels = -1
    d.valid?
    refute_empty d.errors['levels']
  end

  should have_many(:traps).through(:trap_installations)
  should "not list a trap twice if it's been installed more than once" do
    d = Dungeon.create(:name => 'The Great Stygian Abyss', :levels => 8)
    d.trap_installations.create(:trap => traps(:one), :level => 1, :size => 'normal')
    d.trap_installations.create(:trap => traps(:one), :level => 7, :size => 'slightly ridiculous')

    assert_equal 1, d.traps.size
    assert d.traps.include?(traps(:one))
  end

  context "the 'without_an_evil_wizard' scope" do
    should "return dungeons that don't have an evil wizard" do
      d1 = Dungeon.create!(:name => 'Despair', :levels => 4)
      d2 = Dungeon.create!(:name => 'Destard', :levels => 6)

      d1.create_evil_wizard(:name => 'David Blaine', :magic_school => 'stage', :experience_points => 450)

      fetched = Dungeon.without_an_evil_wizard

      assert fetched.include?(d2)
      refute fetched.include?(d1)
    end
  end

  context "the experience points for defeating the dungeon" do
    should "be automatically set during saving" do
      d = Dungeon.new(:name => 'Despair', :levels => 4)
      assert_equal 0, d.experience_points
      assert d.save
      refute_equal 0, d.experience_points
    end

    should "be set to 2 to the power of the number of levels" do
      d = Dungeon.create(:name => 'Despair', :levels => 12)
      assert_equal 2**12, d.experience_points
    end

    should "be changed during updates if we change the number of levels of the dungeon" do
      d = Dungeon.create(:name => 'Despair', :levels => 4)
      old_xp = d.experience_points
      d.levels = 9
      d.save
      refute_equal old_xp, d.experience_points
    end
  end
end
