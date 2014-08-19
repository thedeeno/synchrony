(function() {
  // Paints locations on graph
  Synchrony.draw_locations = function() {
    var svg = this.graph;
    var data = this.locations;
    var height = function(d) { 
      d.item_count = d.item_count || 0;
      d.h = 5 + d.item_count * 5; return d.h; 
    };

    // bind data
    locations = svg.selectAll(".location")
      .data(data);

    // update
    locations
      .attr("height", height);

    // enter
    locations.enter()
      .append("rect")
        .attr("class", "location")
        .attr("id", function(d, i) { return d.id; })
        .attr("x", function(d, i) { d.x = i * 10 + 28; return d.x; })
        .attr("y", function(d, i) { d.y = 150; return d.y; })
        .attr("width", function(d) { d.w = 5; return d.w; })
        .attr("height", height);

  }
}).call();
