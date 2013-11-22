var page = require('webpage').create();
var system = require('system');

var lastReceived = new Date().getTime(),
    requestCount = 0,
    responseCount = 0,
    requestIds = [],
    startTime = new Date().getTime();

var checkComplete = function() {
  // Return after all requests are finished or after 5 seconds
  if ((new Date().getTime() - lastReceived > 300 && requestCount === responseCount) ||
      new Date().getTime() - startTime > 5000) {
    clearInterval(checkCompleteInterval);
    console.log(page.content);
    phantom.exit();
  }
}

page.onResourceReceived = function(response) {
  if (requestIds.indexOf(response.id) !== -1) {
    lastReceived = new Date().getTime();
    responseCount++;
    requestIds[requestIds.indexOf(response.id)] = null;
  }
};

page.onResourceRequested = function(request) {
  if (requestIds.indexOf(request.id) === -1) {
    requestIds.push(request.id);
    requestCount++;
  }
};

// Open the page
page.open(system.args[1], function() {});

// Check to see if the page is finished rendering
var checkCompleteInterval = setInterval(checkComplete, 1);
