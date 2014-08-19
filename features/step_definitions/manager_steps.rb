Given(/^a manager$/) do
  @manager = Synchrony::Acceptance::ManagerAgent.new
end

When(/^the manager opens (?:his|her) monitor app$/) do
  @manager.open_monitor_app
end

Then(/^the manager should see:$/) do |text|
  # assert manager can see specified count of each selector
  lines = text.split("\n")
  lines.each do |x|
    count, selector = x.split(/\s+/)
    @manager.see!(selector, count)
  end
end

Then(/^the manager should see (\d+) employees$/) do |count|
  @manager.see!(".employee", count)
end

Then(/^the manager should see (\d+) containers$/) do |count|
  @manager.see!(".container", count)
end
