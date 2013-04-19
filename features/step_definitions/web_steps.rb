Given(/^I am on the homepage$/) do
  visit "/"
end

Then(/^I should see "([^"]*)"$/) do |text|
  should have_content(text)
end

Then(/^I should not see "([^"]*)"$/) do |text|
  should_not have_content(text)
end

Then(/^I should see "([^"]*)" within "([^"]*)"$/) do |text,obj|
  within(obj) do
    should have_content(text)
  end
end

Then(/^I should not see "([^"]*)" within "([^"]*)"$/) do |text,obj|
  within(obj) do
    should_not have_content(text)
  end
end

Then(/^there should be an object "([^"]*)"$/) do |obj|
  should have_css(obj)
end

Then(/^there should not be an object "([^"]*)"$/) do |obj|
  should_not have_css(obj)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |form_item, input|
  fill_in form_item, with: input
end

When(/^I select "([^"]*)" from "([^"]*)"$/) do |input, sel|
  select input, :from => sel
end

When(/^I press "([^"]*)"$/) do |button|
  click_button button
end

When(/^I follow "([^"]*)"$/) do |link|
  click_link link
end

When(/^I follow "([^"]*)" within "([^"]*)"$/) do |link,obj|
  within(obj) do
    click_link link
  end
end

