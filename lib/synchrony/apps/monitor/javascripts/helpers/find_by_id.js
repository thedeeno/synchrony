(function(){
  Synchrony.find_by_id = function(list, id) {
    return _.find(list, function(x) { return x.id == id });
  }
}).call();

