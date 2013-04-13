require "#{Rails.root}/db/seed_helper.rb"

Given(/^there is a word "([^"]*)"$/) do |name|
  @word = FactoryGirl.create(:word, name: name)
end

Given(/^that word has phonemes:$/) do |table|
  table.hashes.each_with_index do |attributes,i|
    phoneme = Phoneme.find(:all, :conditions => attributes).first
    @word.word_phonemes.create!({:phoneme_id => phoneme.id, :order => i})
  end
end

When(/^there are (\d+) other words$/) do |number|
  number.to_i.times { FactoryGirl.create!(:word) }
end

Then(/^I should not see all words$/) do
  should_not satisfy { |page| Word.all.map { |word| page.has_content?(word.name) }.all? }
end

Then(/^I should see some words$/) do
  should satisfy { |page| Word.all.map { |word| page.has_content?(word.name) }.any? }
end

When(/^I load more words$/) do
  seed_words("#{Rails.root}/data/cmudict.0.7a.partial",false)
end

Then(/^I should see that "([^"]*)" does rhyme with "([^"]*)"$/) do |word2, word1|
  steps(%Q{
    When I fill in "word[name]" with "#{word1}"
    And I press "Rap"
    Then I should see "#{word1}" within "#title_table td.title_word h2"
    And I should see "#{word1}" within "#wr_heading_row"
    And I should see "#{word2}" within "#wr_#{word2}"
    And I should see "rhymes" within "#wr_#{word2}"
  })
end

Then(/^I should see that "([^"]*)" does not rhyme with "([^"]*)"$/) do |word2, word1|
  steps(%Q{
    When I fill in "word[name]" with "#{word1}"
    And I press "Rap"
    Then I should see "#{word1}" within "#title_table td.title_word h2"
    And I should see "#{word1}" within "#wr_heading_row"
    
    And I should see "#{word2}" within "#wr_#{word2}"
    And I should not see "rhymes" within "#wr_#{word2}"
  })
end