(function(){
  Synchrony.subscribe = function() {
    // connect to message service
    var client = this.client = new Faye.Client('/faye');

    // listen for changes to production floor metadata
    client.subscribe('/containers/new', function(message) {
      var new_containers = eval(message.containers);
      Synchrony.containers = Synchrony.containers.concat(new_containers);
      Synchrony.draw_containers();
    });

    // listen for changes to production floor metadata
    client.subscribe('/locations/new', function(message) {
      var new_locations = eval(message.locations);
      Synchrony.locations = Synchrony.locations.concat(new_locations);
      Synchrony.draw_locations();
    });

    // listen for changes to logged in employees
    client.subscribe('/employees/login', function(message) {
      console.log(message.employees);
      var employees = eval(message.employees);
      console.log(employees[0]);
      Synchrony.employees.push(employees[0]);
      Synchrony.draw_employees();
    });

    // listen for pickup events
    client.subscribe('/pickup', function(data) {
      Synchrony.pickup(data.employee_id, data.container_id);
    });

    // listen for dropoff events
    client.subscribe('/dropoff', function(data) {
      Synchrony.dropoff(data.employee_id, data.location_id);
    });
  }

}).call();
