Given(/^an available synchrony app$/) do
  @app = Synchrony::Acceptance::App.new
  expect(@app).to be_available
end

