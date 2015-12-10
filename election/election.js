exports.tally = function(votes) {
  var len = votes.length;
  var majority = Math.floor( len / 2 ) + 1;
  var votecount = {};
  for (var i = 0;i < len;i++) {
    var valueString = votes[i].toString();
    if (votecount[valueString]) {
      votecount[valueString] += 1;
      if (votecount[valueString] >= majority) {
        return [votes[i]];
      }
    }
    else {
      votecount[valueString] = 1;
    }
  }

  var first = 0;
  var second = 0;
  var third = 0;

  Object.keys(votecount).forEach(function(key) {
    var value = votecount[key];
    if (value > first) {
      third = second;
      second = first;
      first = votecount[key];
    }
    else if (value == first) {}
    else if (value > second) {
      third = second;
      second = value;
    }
    else if (value == second) {}
    else if (value > third) {
      third = value;
    }
  });

  var results = []
  Object.keys(votecount).forEach(function(key) {
    if (votecount[key] == first) {
      results.push(parseInt(key));
    }
  });
  if (results.length >= 3) {
    return results;
  }

  Object.keys(votecount).forEach(function(key) {
    if (votecount[key] == second) {
      results.push(parseInt(key));
    }
  });
  if (results.length >= 3) {
    return results;
  }

  Object.keys(votecount).forEach(function(key) {
    if (votecount[key] == third) {
      results.push(parseInt(key));
    }
  });
  if (results.length >= 3) {
    return results;
  }
}
