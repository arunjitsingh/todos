@import <Foundation/CPObject.j>

@implementation Task : CPObject {
//  @private
	CPString	__id;
	CPString 	_id 			@accessors(property=ID);
//  @public
	BOOL	 	_completed 		@accessors(getter=isCompleted, setter=setCompleted:);
	CPString	_description 	@accessors(property=task);
	
	CPURL		_URL			@accessors(property=URL, readonly);
}

+ (Task)taskFromJSObject:(JSObject)anObject {
	if (typeof(anObject)==="string") {
		anObject = JSON.parse(anObject);
	}
	if (anObject._id != undefined && anObject.id != undefined) {
		var task = [[Task alloc] init];
		task.__id = anObject._id;
		[task setID:anObject.id];
		[task setCompleted: anObject.completed ? YES : NO];
		[task setTask:(anObject.description || anObject.task || @"")];
		task._URL = [CPURL URLWithString:"/task/"+[task ID]];
		return task;
	} else {
	//	[CPException raise:@"MalformedTaskObjectException"
	//			    reason:"Object is not a task: " + [CPString JSONFromObject:anObject]];
		return nil;
	}
}

+ (Task)taskWithTask:(CPString)aTask {
	var task = {'description':aTask, 'completed':false, 'id':"", '_id':""};
	return [Task taskFromJSObject:task];
}

- (CPURLRequest)deleteRequest {
	var request = [CPURLRequest requestWithURL:[self URL]];
	[request setHTTPMethod:@"DELETE"];
	[request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	return request;
}

- (CPURLRequest)updateRequestWithHTTPBody:(CPString)bodyString {
	var request = [CPURLRequest requestWithURL:[self URL]];
	[request setHTTPMethod:@"PUT"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	[request setHTTPBody:bodyString];
	return request;
}

- (CPString)JSONString {
	var task = {
		'completed':[self isCompleted],
		'description':[self task],
		'id':[self ID],
		'_id':self.__id
	};
	return [CPString JSONFromObject:task];
}

- (void)toggleCompleted {
	self._completed = !self._completed;
}

@end