Given(/^an admin$/) do
  @admin = Synchrony::Acceptance::AdminAgent.new(@app)
end

When(/^the admin adds (\d+) containers$/) do |count|
  @admin.add_containers(count.to_i)
end

When(/^the admin adds (\d+) locations$/) do |count|
  @admin.add_locations(count.to_i)
end

