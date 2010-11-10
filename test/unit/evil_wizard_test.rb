require 'test_helper'

class EvilWizardTest < ActiveSupport::TestCase
  test "should require a name" do
    e = EvilWizard.new
    e.name = nil
    e.valid?
    refute_empty e.errors['name']
  end

  test "should require that the name is no more than 200 characters" do
    e = EvilWizard.new
    e.name = 'a' * 201
    e.valid?
    refute_empty e.errors['name']
  end

  test "should allow the name to be exactly 200 characters" do
    e = EvilWizard.new
    e.name = 'a' * 200
    e.valid?
    assert_empty e.errors['name']
  end

  test "should not allow evil wizards with duplicate names" do
    e = EvilWizard.create!(:name => 'Batlin', :experience_points => 800, :magic_school => 'fire', :dungeon => Dungeon.create(:name => 'The Great Stygian Abyss', :levels => 8))
    e2 = EvilWizard.new(:name => 'Batlin')
    e2.valid?
    refute_empty e2.errors['name']
  end

  test "should require the number of experience points to be received when defeating the wizard" do
    e = EvilWizard.new
    e.experience_points = nil
    e.valid?
    refute_empty e.errors['experience_points']
  end

  test "should require the number of experience points to be received when defeating the wizard to be more than 0" do
    e = EvilWizard.new
    e.experience_points = -1
    e.valid?
    refute_empty e.errors['experience_points']
  end

  test "should require the number of experience points to be received when defeating the wizard to be no more than 1000" do
    e = EvilWizard.new
    e.experience_points = 1001
    e.valid?
    refute_empty e.errors['experience_points']
  end

  test "should allow the number of experience points to be received when defeating the wizard to be exactly 1000" do
    e = EvilWizard.new
    e.experience_points = 1000
    e.valid?
    assert_empty e.errors['experience_points']
  end

  test "should require that the wizard belongs to a dungeon" do
    e = EvilWizard.new
    e.dungeon = nil
    e.valid?
    refute_empty e.errors['dungeon']
  end

  test "should require that the wizard has a school of magic" do
    e = EvilWizard.new
    e.magic_school = nil
    e.valid?
    refute_empty e.errors['magic_school']
  end

  test "should allow the wizard's school of magic to be one of the pre-defined ones" do
    e = EvilWizard.new
    EvilWizard::MAGIC_SCHOOLS.each do |valid_magic_school|
      e.magic_school = valid_magic_school
      e.valid?
      assert_empty e.errors['magic_school']
    end
  end

  test "should disallow the wizard's school of magic if it's not one of the pre-defined ones" do
    e = EvilWizard.new
    e.magic_school = 'not likely to be a valid school of magic'
    e.valid?
    refute_empty e.errors['magic_school']
  end
end
