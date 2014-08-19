(function(){
  var Synchrony = this.Synchrony || {};

  Synchrony.graph = d3.select("body").append("svg")
    .attr("width", "500") 
    .attr("height", "200") 

  // Synchrony.containers = [{id:1}, {id: 2}];
  // Synchrony.employees = [{id: 1}, {id: 2}];
  // Synchrony.locations = [{id: 1}];

  Synchrony.containers = [];
  Synchrony.employees = [];
  Synchrony.locations = [];

  Synchrony.draw_containers();
  Synchrony.draw_employees();
  Synchrony.draw_locations();

  Synchrony.subscribe();

  $(document).on("click", "button", function() {
    Synchrony.pickup(1, 1);
    setTimeout(function() { Synchrony.pickup(2, 2) }, 2000);
    setTimeout(function() { Synchrony.dropoff(1, 1) }, 4000);
    setTimeout(function() { Synchrony.dropoff(2, 1) }, 6000);
  });

}).call();
