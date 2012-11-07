When /^I enter "(.*?)"$/ do |keys|
  @input = keys;
  keys.split("").each do |key|
    touch("button marked:'#{key}'")
  end
end

Then /^I should see this in the display$/ do
  text = frankly_map("view marked:'displayLabel", "text").first
  text.should == @input
end
