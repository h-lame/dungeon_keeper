require 'test_helper'

class AddingADungeonAndThenTheEvilWizardForItTest < ActionDispatch::IntegrationTest
  test "do it" do
    get "/dungeons/new"
    assert_select "input[name=?]", 'dungeon[name]'
    assert_select "input[name=?]", 'dungeon[levels]'

    post "/dungeons", :dungeon => {:name => 'Despair', :levels => 8}
    my_new_dungeon = assigns(:dungeon)
    assert_redirected_to dungeon_path(my_new_dungeon)
    follow_redirect!

    assert_select "h1", :text => "Dungeon: Despair"
    assert_select "p", :text => /Levels:\s+8/
    assert_select "p", :text => /Experience points:\s+256/
    assert_select ".evil_wizard a[href=?]", new_evil_wizard_path, :text => 'why not add one?'

    get "/evil_wizards/new"
    assert_select "input[name=?]", 'evil_wizard[name]'
    assert_select "input[name=?]", 'evil_wizard[experience_points]'
    assert_select "select[name=?]", 'evil_wizard[dungeon_id]' do
      assert_select "option[value=?]", my_new_dungeon.id, :text => 'Despair'
    end
    assert_select "select[name=?]", 'evil_wizard[magic_school]' do
      assert_select "option", :text => 'chaos'
    end

    post "/evil_wizards", :evil_wizard => {:name => 'Batlin', :experience_points => 100, :magic_school => 'chaos', :dungeon_id => my_new_dungeon.id}
    my_new_wizard = assigns(:evil_wizard)
    assert_redirected_to evil_wizard_path(my_new_wizard)
    follow_redirect!

    assert_select "h1", :text => "Evil Wizard: Batlin"
    assert_select "p", :text => /Experience points:\s+100/
    assert_select "p", :text => /Magic school:\s+chaos/
    assert_select "p", :text => /Dungeon:\s+Despair/
    assert_select "a[href=?]", dungeon_path(my_new_dungeon), :text => 'Despair'

    get dungeon_path(my_new_dungeon)
    assert_select "p", :text => /Evil Wizard:\s+Batlin/
    assert_select "a[href=?]", evil_wizard_path(my_new_wizard), :text => 'Batlin'
  end
end
