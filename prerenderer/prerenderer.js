var path = require('path'),
    spawn = require('child_process').spawn,
    express = require('express'),
    app = express();

var getContent = function(url, callback) {
  var phantom, content = '',
      phantomjs = path.normalize(__dirname + '/../node_modules/.bin/phantomjs');

  // Spawn a phantom-server.js process
  phantom = spawn(phantomjs, ['phantom-server.js', url], {cwd: __dirname});
  phantom.stdout.setEncoding('utf8');

  // phantom-server.js script is simply logging the output,
  // which can be accessed through stdout
  phantom.stdout.on('data', function(data) {
    content += data.toString();
  });

  phantom.on('exit', function(code) {
    if (code !== 0) {
      console.log('Error');
      console.log(code);
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
