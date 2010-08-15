var mongoose = require('mongoose').Mongoose;
mongoose.model("Task", {
	collection: "tasks",
	
	properties: ['id', 'completed', 'description'],
		
	methods: {
		save: function(fn, updateOnly) {
			if (!updateOnly) {
				var now = (new Date()).getTime();
				this.id = now.toString(36);
			}
			this.__super__(fn);
		}
	}
});
var db = mongoose.connect("mongodb://localhost/todos");

var Todos = {VERSION:'1.0'};

Todos.Task = db.model("Task");

Todos.retrieve = function() {
	var fn,
		id;
	switch (arguments.length) {
		case 1:
			fn = arguments[0];
			if ("function"===typeof(fn)) {
				Todos.Task.find().all(fn);
			}
			break;
		case 2:
			id = arguments[0];
			fn = arguments[1];
			if ("function"===typeof(fn)) {
				Todos.Task.find({'id':id}).all(fn);
			}
			break;
		default:
	}
};

/*
 Subsets are not implemented yet
Todos.fetch = function(offset, limit, fn) {
	Todos.Task.find({}, {$slice:[offset, limit]}).all(fn);
};
*/
Todos.create = function(data, fn) {
	var task = new Todos.Task();
	task.completed = data.completed ? true : false;
	task.description = data.description || data.task || "";
	task.save(fn);
	return task;
};

Todos.destroy = function(id, fn) {
	Todos.Task.remove({'id':id}, fn);
};

Todos.update = function(id, data, fn) {
	if (!data) {
		return;
	}

	Todos.Task.find({'id':id}).all(function(array) {
		var task = array[0];
		if (typeof(task)==="string") task = JSON.parse(task);
//		console.log(JSON.stringify(task));
		Todos.Task.remove({'id':id}, function() {			
			if (typeof(data.completed)!=="undefined") task.completed = data.completed;
			task.description = data.description || data.task || "";			
			
			var update = new Todos.Task();
			update.id = id;
			update.completed = task.completed;
			update.description = task.description;
			update.save(fn, true);
		});
	});
};

Todos.createSampleData = function() {
	Todos.retrieve(function(array) {
		if (!array.length) {
			var tasks = require('./fixtures').tasks;
			tasks.forEach(function(task) {
				task = Todos.create(task);
			});
		}
	});
};

this.Todos = Todos;