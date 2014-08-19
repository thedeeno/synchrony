Given(/^(\d+) employees?$/) do |count|
  count = count.to_i
  count.times { Synchrony::Employee.create }
end

When(/^the employees log in$/) do
  Synchrony::Employee.all.each do |e| 
    expect(@app.login(e.id).code).to eq("200")
  end
end

When(/^the employees? works? until finished$/) do
  while Synchrony::Container.unorganized.count > 0
    e = Synchrony::Employee.signed_in.sample(1).first
    e.reload
    if not e.carrying? and Synchrony::Container.free.count > 0
      @app.pickup(e.id, Synchrony::Container.free.sample(1).first.id)
    else
      @app.dropoff(e.id, Synchrony::Location.all.sample(1).first.id)
    end
    sleep 1
  end
end
