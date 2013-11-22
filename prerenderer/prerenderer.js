var express = require('express');
var app = express();

var getContent = function(url, callback) {
  var content = '';

  // Spawn a phantom-server.js process
  var phantom = require('child_process').spawn('../node_modules/phantomjs/bin/phantomjs', ['phantom-server.js', url]);
  phantom.stdout.setEncoding('utf8');

  // phantom-server.js script is simply logging the output,
  // which can be accessed through stdout
  phantom.stdout.on('data', function(data) {
    content += data.toString();
  });

  phantom.on('exit', function(code) {
    if (code !== 0) {
      console.log('Error');
    } else {
      callback(content);
    }
  });
};

var respond = function (req, res) {
  url = 'http://localhost';
  if (req.headers['x-rewrite-cleanuri']) {
    url += req.headers['x-rewrite-cleanuri'];
  }

  getContent(url, function (content) {
    res.send(content);
  });
}

app.get(/(.*)/, respond);
app.listen(3000);
