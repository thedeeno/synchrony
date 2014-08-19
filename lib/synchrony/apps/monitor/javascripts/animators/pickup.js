(function() {
  var transform = function(d) {
    return d3.svg.transform()
      .translate([d.x, d.y])
      .rotate(d.r)();
  }

  Synchrony.pickup = function(employee_id, container_id) {
    var svg = this.graph;
    var container = this.find_by_id(this.containers, container_id);
    var employee = this.find_by_id(this.employees, employee_id);

    // select employee
    svg.selectAll(".employee[data-id='" + employee_id + "']")

      // move to isle
      .transition()
        .attr("transform", function(d) {
          d.x = container.x - 5;
          return transform(d);
        })

      // move to container
      .transition()
        .attr("transform", function(d) {
          d.y = container.y;
          return transform(d);
        })

      // rotate for pickup
      .transition()
        .attr("transform", function(d) {
          d.r = [ -90, 0, 3 ];
          return transform(d);
        })

      // remove container
      .each("end", function(d) {
        d.carrying = true;
        Synchrony.draw_employees();
        svg.select(".container[cid='" + container.id + "']").remove()
      })

      // rotate back to neutral
      .transition()
        .attr("transform", function(d) {
          d.r = [ 0, 0, 3 ];
          return transform(d);
        })

      // move back to home
      .transition()
        .attr("transform", function(d, i) {
          d.y = d.home_y;
          return transform(d);
        })
      .transition()
        .attr("transform", function(d, i) {
          d.x = d.home_x;
          return transform(d);
        })
  }
}).call();
