// Start up

var mongoose = require('mongoose').Mongoose;
mongoose.model('User', {

    properties: ['first', 'last', 'age', 'updated_at'],

    cast: {
      age: Number,
      'nested.path': String
    },

    indexes: ['first'],

    setters: {
    },

    getters: {
        fullName: function(){ 
            return this.first + ' ' + this.last;
        }
    },

    methods: {
        save: function(fn) {
            this.updated_at = new Date();
            this.__super__(fn);
        }
    }// ,
    // 
    // 	static: {
    // 		seniors: function() {
    // 			return this.find({age:{'$gt':65}});
    // 		}
    // 	}
});

var db = mongoose.connect("mongodb://localhost/db");
var User = db.model('User');

// (function() {
// 	User.find().all(function(array) {
// 		array.forEach(function(e) {
// 			if ("function"===typeof(e.remove)) {
// 				e.remove();
// 			}
// 		});
// 	});
// 	for (var i = 0; i < 10; ++i) {
// 		var u = new User();
// 		u.first = "A"+i;
// 		u.last = "B"+(9-i);
// 		u.save();
// 	}
// })();

// Routes