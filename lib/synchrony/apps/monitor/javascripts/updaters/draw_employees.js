(function() {

  // Paints employees on graph. 
  Synchrony.draw_employees = function() {
    var svg = this.graph;
    var data = this.employees;

    var transform = function(d) {
      return d3.svg.transform()
        .translate([d.x, d.y])
        .rotate(d.r)();
    }

    // bind
    employee = svg.selectAll(".employee")
      .data(data, function(d) { return d.id; });

    // update
    employee
      .classed("carrying", function(d) { return d.carrying });

    employee.enter()
      .append("g")
        .attr("class", "employee")
        .attr("data-id", function(d) { return d.id })
        .attr("transform", function(d, i) {
          d.x = 10 * i + 30;
          d.y = 100;
          d.r = [0,0,0];

          d.home_x = d.x;
          d.home_y = d.y;

          return transform(d);
        });

    var head = employee.append("circle").attr("r", 2);
    var body = employee.append("rect")
      .attr("y", 2)
      .attr("x", -3)
      .attr("width", 6)
      .attr("height", 4)
  }

}).call();
