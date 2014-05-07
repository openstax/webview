var page = require('webpage').create();
var system = require('system');

var lastReceived = new Date().getTime(),
    requestCount = 0,
    responseCount = 0,
    requestIds = [],
    startTime = new Date().getTime();

var checkComplete = function () {
  var content = '', matches;

  // Return after all requests are finished or after 20 seconds - or 10 sec for any one fetch
  if ((new Date().getTime() - lastReceived > 10000 && requestCount === responseCount) ||
      new Date().getTime() - startTime > 20000) {
    clearInterval(checkCompleteInterval);

    content = page.content;
    matches = content.match(/<script(?:.*?)>(?:[\S\s]*?)<\/script>/gi);

    for (var i = 0; matches && i < matches.length; i++) {
      content = content.replace(matches[i], '');
    }

    console.log(content);
    phantom.exit();
  }
};

page.onConsoleMessage = function (msg) {
  system.stderr.write(JSON.stringify(msg, undefined, 4));
};

page.onResourceReceived = function (response) {
  if (requestIds.indexOf(response.id) !== -1) {
    lastReceived = new Date().getTime();
    responseCount++;
    requestIds[requestIds.indexOf(response.id)] = null;
  }
};

page.onResourceRequested = function (request) {
  if (requestIds.indexOf(request.id) === -1) {
    requestIds.push(request.id);
    requestCount++;
  }
};

// Open the page
page.open(system.args[1], function () {});

// Check to see if the page is finished rendering
var checkCompleteInterval = setInterval(checkComplete, 100);
