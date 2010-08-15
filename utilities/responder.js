var extend = function(object, extension) {
	if (extension) {
		for (var p in extension) {
			object[p] = extension[p];
		}
	}
	return object;
};


var Responder = function(response) {
	var self = this;
	self.response = response;
	self.defaultHeaders = {"Content-Type":"text/json", "Cache-Control":"no-cache"};
	
	self.json = function() {
		self.callback = null;
		return self;
	};
	
	self.jsonp = function(callback) {
		self.callback = callback;
		return self;
	};
	
	self.end = function(status, object, headers) {
		if (self.response && parseInt(status, 10)!=NaN && typeof(object)==="object") {
			if (typeof(object.status)==="undefined") {
				object.status = ~~(status/100)==2 ? true : false;
			}
			self.response.writeHead(status, extend(self.defaultHeaders, headers));
			
			if (self.callback) {
				self.response.end(self.callback + "(" + JSON.stringify(object) + ")");
			} else {
				self.response.end(JSON.stringify(object));
			}
		}
	};
	
	return self;
};

this.Responder = Responder;