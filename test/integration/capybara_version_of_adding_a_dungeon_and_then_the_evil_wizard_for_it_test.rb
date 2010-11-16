require 'test_helper'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rails'

class AddingADungeonAndThenTheEvilWizardForItTest < ActionDispatch::IntegrationTest
  include Capybara
  test "do it" do
    visit "/dungeons/new"

    fill_in "Name", :with => 'Despair'
    fill_in "Levels", :with => '8'

    click_button "Create"

    my_new_dungeon = Dungeon.where(:name => 'Despair').first
    assert_not_nil my_new_dungeon
    assert_equal dungeon_path(my_new_dungeon), current_path

    assert page.has_xpath?("//h1[contains(text(), 'Dungeon: Despair')]")
    within('//p') do
      assert page.has_content?('Levels: 8')
      assert page.has_content?('Experience points: 256')
    end

    click_link 'why not add one?'

    assert "/evil_wizards/new", current_path

    fill_in 'Name', :with => 'Batlin'
    fill_in 'Experience points', :with => '100'
    select 'Despair', :from => 'Dungeon'
    select 'chaos', :from => 'Magic school'

    click_button "Create"

    my_new_wizard = EvilWizard.where(:name => 'Batlin').first
    assert_not_nil my_new_wizard
    assert_equal evil_wizard_path(my_new_wizard), current_path

    assert page.has_xpath?("//h1[contains(text(), 'Evil Wizard: Batlin')]")
    within('//p') do
      assert page.has_content?('Experience points: 100')
      assert page.has_content?('Magic school: chaos')
      assert page.has_content?('Dungeon: Despair')
    end
    click_link 'Despair'

    assert_equal dungeon_path(my_new_dungeon), current_path
    assert page.has_css?("p", :content => 'Evil Wizard: Batlin')
    assert page.has_css?("a", :href=> evil_wizard_path(my_new_wizard), :content => 'Batlin')
  end
end
