Given /^the following there_should_be_monsters:$/ do |there_should_be_monsters|
  ThereShouldBeMonsters.create!(there_should_be_monsters.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) there_should_be_monsters$/ do |pos|
  visit there_should_be_monsters_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following there_should_be_monsters:$/ do |expected_there_should_be_monsters_table|
  expected_there_should_be_monsters_table.diff!(tableish('table tr', 'td,th'))
end
