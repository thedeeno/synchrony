(function() {

  Synchrony.draw_containers = function() {
    var svg = this.graph;
    var data = this.containers;
    var rows = 5;
    var isle_width = 20;

    containers = svg.selectAll(".container")
      .data(data);

    // update
    containers
      .classed("filled", function(d) { return d.filled; })

    // wait a max of 500ms for new containers to paint
    var delay_scale = d3.scale.linear()
      .domain([0, data.length])
      .range([0, 500])

    containers.enter()
      .append("svg:rect")
        .attr("class", "container")
        .attr("width", 0)
        .attr("height", 0)
        .attr("x", function(d, i) {
          d.x = Math.floor(i / rows) * isle_width + isle_width;
          return d.x;
        })
        .attr("y", function(d, i) {
          d.y = i % rows * 10;
          return d.y;
        })
        .attr("cid", function(d, i) { return d.id; })
      .transition()
        .delay(function(d, i) { return delay_scale(i); })
        .attr("width", 5)
        .attr("height", 5)

    containers.exit().remove();
  }

}).call();
