require 'test_helper'

class EvilWizardTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_most(200)
  should validate_uniqueness_of(:name)

  should validate_presence_of(:experience_points)
  should ensure_inclusion_of(:experience_points).in_range(0..1000).with_high_message(default_error_message(:less_than_or_equal_to, :count => 1000))

  should validate_presence_of(:dungeon)

  should validate_presence_of(:magic_school)
  EvilWizard::MAGIC_SCHOOLS.each do |valid_magic_school|
    should allow_value(valid_magic_school).for(:magic_school)
  end

  should " disallow the wizard's school of magic if it's not one of the pre-defined ones" do
    e = EvilWizard.new
    e.magic_school = 'not likely to be a valid school of magic'
    e.valid?
    refute_empty e.errors['magic_school']
  end
end
