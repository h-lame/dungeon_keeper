require 'spec_helper'

describe ApplicationHelper do
  context "actions_menu" do
    it "should wrap each argument in a <li> inside a single <ul> with the class 'actions'" do
      actions_menu('whatever', 'i', 'want').should have_selector('.actions_menu') do |scope|
        scope.should have_selector('.action:first-child', :content => 'whatever')
        scope.should have_selector('.action', :content => 'i')
        scope.should have_selector('.action:last-child', :content => 'want')
      end
    end

    it "actions_menu should output nothing if no arguments are supplied" do
      actions_menu.should be_blank
    end
  end

  context "yes_or_no" do
    it "should return 'yes' if the supplied argument is truthy" do
      [true, '', :a_thing].each do |truthy_value|
        yes_or_no(truthy_value).should == 'yes'
      end
    end

    it "should return 'no' if the supplied argument is falsy" do
      [false, nil].each do |falsy_value|
        yes_or_no(falsy_value).should == 'no'
      end
    end
  end
end
