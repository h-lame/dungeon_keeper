Feature: There should be monsters in my dungeon
  In order to manage what types of monsters are available to my dungeons
  As a dungeon master
  I want to be able to see a list of monsters, add new ones, edit them and also delete them

  Scenario: Adding a monster to my list dungeons
    Given I am on the new monster page
     When I fill in "Name" with "Orc"
      And I select "very" from "Scariness"
      And I press "Create"
     Then I should see "Monster: Orc"
      And I should see "Scariness: very"
     When I follow "See all monsters"
     Then I should be on the page that lists all monsters
      And I should see "Orc"
