Feature: Manage dungeons
  In order to maintain a list of my dungeons
  As a dungeon master
  I want to be able to add, edit and delete dungeons

  Scenario: After registering a new dungeon I am prompted to create an evil wizard for it
    Given I am on the new dungeon page
     When I fill in "Name" with "Despair"
      And I fill in "Levels" with "8"
      And I press "Create"
     Then I should see "Despair"
      And I should see "Levels: 8"
      And I should see "Experience points: 256"
      And I should be prompted to add an evil wizard to the dungeon
     When I follow "why not add one?"
      And I fill in "Name" with "Batlin"
      And I select "Despair" from "Dungeon"
      And I select "chaos" from "Magic school"
      And I fill in "Experience points" with "100"
      And I press "Create"
     Then I should see "Batlin"
      And I should see "Magic school: chaos"
      And I should see "Experience points: 100"
      And I should see "Dungeon: Despair"
     When I follow "Despair"
     Then I should be on the page for dungeon called "Despair"

  Scenario: When I have a dungeon I no longer need I can delete it and doing so remove the evil wizard too
    Given the following dungeons exist:
        | name             |
        | Despair          |
        | Castle Britannia |
      And the following evil wizards exist:
        | name         | Dungeon                |
        | Batlin       | name: Despair          |
        | Lord British | name: Castle Britannia |
     When I go to the page with the list of evil wizards
     Then I should see that "Despair" is the dungeon that the evil wizard "Batlin" is in
      And I should see that "Castle Britannia" is the dungeon that the evil wizard "Lord British" is in
     When I go to the page with the list of dungeons page
     Then I should see that "Batlin" is the evil wizard in dungeon "Despair"
      And I should see that "Lord British" is the evil wizard in dungeon "Castle Britannia"
     When I press delete for dungeon "Despair"
     Then I should be on the page with the list of dungeons
      And I should not see "Despair"
     When I go to the page with the list of evil wizards
     Then I should not see "Batlin"
