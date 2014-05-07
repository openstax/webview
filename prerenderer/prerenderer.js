var path = require('path'),
    spawn = require('child_process').spawn,
    express = require('express'),
    app = express();

var getContent = function (url, callback) {
  var phantom, content = '',
      phantomjs = path.normalize(__dirname + '/../node_modules/.bin/phantomjs');

  // Spawn a phantom-server.js process
  phantom = spawn(phantomjs, ['--web-security=false', 'phantom-server.js', url], {cwd: __dirname});
  phantom.stdout.setEncoding('utf8');

  // phantom-server.js script is simply logging the output,
  // which can be accessed through stdout
  phantom.stdout.on('data', function (data) {
    content += data.toString();
  });

  phantom.stderr.on('data', function (data) {
    console.log(data.toString());
  });

  phantom.on('exit', function (code) {
    if (code !== 0) {
      console.log('Error');
      console.log(code);
    } else {
      callback(content);
    }
  });
};

var respond = function (req, res) {
  url = 'http://'
  if (req.headers['x-rewrite-cleanhost']) {
    url += req.headers['x-rewrite-cleanhost'];
  } else {
    url += req.headers['host'];
  }
  if (req.headers['x-rewrite-cleanuri']) {
    url += req.headers['x-rewrite-cleanuri'];
  } else {
    url += req.url;
  }
  console.log(url)


  getContent(url, function (content) {
    //force caching for 30 days - may need to do something diff for diff urls in the future
    var expdate = new Date();
    expdate.setDate(expdate.getDate() + 30);
    res.set('expires',expdate.toUTCString());
    res.set('cache-control','public, max-age=2592000, s-maxage=2592000'),
    res.send(content);
  });
}

app.get(/(.*)/, respond);
app.listen(4000);
