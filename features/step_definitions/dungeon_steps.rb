Then(/^I should see the following dungeons:$/) do |expected_dungeons_table|
  expected_dungeons_table.rows.each do |row|
    within(".dungeon") do
      row.each do |cell|
        assert page.has_content?(cell)
      end
    end
  end
end

Then(/^I should be prompted to add an evil wizard to the dungeon$/) do
  within(".evil_wizard") do
    assert page.has_xpath?("//a[@href='#{new_evil_wizard_path}'][contains(text(), 'why not add one?')]")
  end
end

Then(/^I should see that "([^"]*)" is the dungeon that the evil wizard "([^"]*)" is in$/) do |dungeon_name, evil_wizard_name|
  e = EvilWizard.where(:name => evil_wizard_name).first
  d = Dungeon.where(:name => dungeon_name).first
  within(".evil_wizards #evil_wizard_#{e.id}") do
    assert page.has_content?(evil_wizard_name)
    assert page.has_xpath?("//a[@href='#{dungeon_path(d)}'][contains(text(), '#{dungeon_name}')]")
  end
end

Then(/^I should see that "([^"]*)" is the evil wizard in dungeon "([^"]*)"$/) do |evil_wizard_name, dungeon_name|
  d = Dungeon.where(:name => dungeon_name).first
  e = EvilWizard.where(:name => evil_wizard_name).first
  within(".dungeons #dungeon_#{d.id}") do
    assert page.has_content?(dungeon_name)
    assert page.has_xpath?("//a[@href='#{evil_wizard_path(e)}'][contains(text(), '#{evil_wizard_name}')]")
  end
end

When(/^I press delete for dungeon "([^"]*)"$/) do |dungeon_name|
  d = Dungeon.where(:name => dungeon_name).first
  within("#dungeon_#{d.id}") do
    click_link "Destroy"
  end
end
