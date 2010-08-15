/**
 * Module dependencies.
 */

var     sys = require('sys'),
	express = require('express'),
    connect = require('connect'),
  Responder = require('./utilities/responder').Responder,
	  Todos = require('./todos').Todos;

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
	app.set("root", __dirname);
    app.use(connect.bodyDecoder());
    app.use(connect.methodOverride());
	app.use(connect.logger({format: '[:remote-addr]:method :url'}));
	app.use(connect.gzip());
	app.use(connect.conditionalGet());
	app.use(connect.cache());
//	app.use(connect.session());
	app.use(connect.staticProvider(__dirname + '/todos'));
    app.use(app.router);
});

app.configure('development', function(){
    app.use(connect.errorHandler({ dumpExceptions: true, showStack: true })); 
});

app.configure('production', function(){
   app.use(connect.errorHandler()); 
});

(function () {
	Todos.createSampleData();
})();

app.get('/', function(request, response) {
	response.render('./todos/');
});

app.get('/tasks?', function(request, response) {
//	console.log(JSON.stringify([request.params, request.param('callback')]));
	Todos.retrieve(function(array) {
		var object = {status:true, results:array};
	//	response.writeHead(200, {"Content-Type":"text/json"});
	//	response.end(JSResponse(request, object));
		Responder(response).jsonp(request.param('callback')).end(200, object);
	});    
});

app.get('/task/:id', function(request, response) {
//	console.log(JSON.stringify(request.params));
	var id = request.params.id;
	Todos.retrieve(id, function(array) {
		var object = {status:true, results:array};
		response.writeHead(200, {"Content-Type":"text/json"});
		response.end(JSResponse(request, object));
	});    
});

app.post('/', function(request, response) {
	response.writeHead(301, {"Content-Type":"text/json", Location:"task"});
	response.end(JSON.stringify({status:false, error:"You cannot POST to this URL. Try [POST] /task"}));
});

app.post('/task', function(request, response) {
	var data = request.body.data;
	if (data) {
		Todos.create(data, function() {
			response.writeHead(201, {"Content-Type":"text/json"});
			response.end(JSON.stringify({success:true}));
		});
	} else {
		console.log(JSON.stringify(request.body));
		response.writeHead(400, {"Content-Type":"text/json"});
		response.end(JSON.stringify({success:false, error:"Task could not be created: no data found"}));
	}
});

// Only listen on $ node app.js

if (!module.parent) {
    app.listen(8800);
    require('sys').puts("TODOS running on http://127.0.0.1:8800");
}

/*
 * Returns a string that can be printed out at response.
 * Requires request to check if response should be JSONP
 * JSONP callback parameter is "callback"
 */

var JSResponse = function(request, object) {
	var callback = request.param('callback');
	if (callback) {
		return (callback+"(" + JSON.stringify(object) + ")");
	} else {
		return (JSON.stringify(object));
	}
};