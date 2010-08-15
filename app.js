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

app.get('/tasks', function(request, response) {
//	console.log(JSON.stringify([request.params, request.param('callback')]));
	Todos.retrieve(function(array) {
		var object = {status:true, results:array};
		Responder(response).jsonp(request.param('callback')).end(200, object);
	});    
});

app.get('/task/:id', function(request, response) {
//	console.log(JSON.stringify(request.params));
	var id = request.params.id;
	Todos.retrieve(id, function(array) {
		var object = {status:true, results:array};
		Responder(response).jsonp(request.param('callback')).end(200, object);
	});    
});

app.post('/', function(request, response) {
	Responder(response)
		.jsonp(request.param('callback'))
		.end(301, {status:false, error:"You cannot POST to this URL. Try [POST] /task"},
		 	 {Location:"task"});
});

app.post('/task', function(request, response) {
	var data = request.body;
	if (data) {
		Todos.create(data, function() {
			Responder(response).jsonp(request.param('callback')).end(201, {success:true});
		});
	} else {
		console.log(JSON.stringify(request.body));
		Responder(response)
			.jsonp(request.param('callback'))
			.end(400, {success:false, error:"Task could not be created: no data found"});
	}
});

app.put('/task/:id', function(request, response) {
	var data = request.body;
	if (data) {
		var id = request.params.id;
		Todos.update(id, data, function() {
			Responder(response).jsonp(request.param('callback')).end(200, {success:true});
		});
	} else {
		console.log(JSON.stringify(request.body));
		Responder(response)
			.jsonp(request.param('callback'))
			.end(400, {success:false, error:"Task could not be created: no data found"});
	}
});

app.del('/task/:id', function(request, response) {
	var id = request.params.id;
	Todos.destroy(id, function(array) {
		Responder(response).jsonp(request.param('callback')).end(200, {success:true});
	});
});


// Only listen on $ node app.js

if (!module.parent) {
    app.listen(8800);
    sys.puts("TODOS running on http://127.0.0.1:8800");
	sys.puts("Keep this process running (ie, do not close this window, or quit this application)!");
}