(function() {
  var transform = function(d) {
    return d3.svg.transform()
      .translate([d.x, d.y])
      .rotate(d.r)();
  }

  Synchrony.dropoff = function(employee_id, location_id) {
    var svg = this.graph;
    var location = this.find_by_id(this.locations, location_id); 
    var employee = this.find_by_id(this.employees, employee_id);

    // select employee
    svg.selectAll(".employee[data-id='" + employee_id + "']")

      // translate y
      .transition()
        .attr("transform", function(d) {
          d.y = location.y - 8;
          return transform(d);
        })

      // translate x
      .transition()
        .attr("transform", function(d) {
          d.x = location.x + location.w/2;
          return transform(d);
        })

      // pause before dropoff
      .transition()
        .attr("transform", function(d) { return transform(d); })

      // flash
      // .style("fill", "red")
      // .transition()
      //   .style("fill", "black")

      // dropoff
      .each(function(d) {
        svg.selectAll(".location[id='" + location.id + "']")
          .transition()
            .duration(20)
            .attr("height", function(d) { d.h += 5; return d.h; });
      })

      .each("start", function(d) {
        d.carrying = false;
        Synchrony.draw_employees();
      })

      // translate back to neutral position
      .transition()
        .attr("transform", function(d) {
          d.x = d.home_x;
          return transform(d);
        })
      .transition()
        .attr("transform", function(d) {
          d.y = d.home_y;
          return transform(d);
        });
  }
}).call();
