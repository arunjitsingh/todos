@STATIC;1.0;I;21;Foundation/CPObject.jt;3675;

objj_executeFile("Foundation/CPObject.j", NO);

{var the_class = objj_allocateClassPair(CPObject, "Task"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("__id"), new objj_ivar("_id"), new objj_ivar("_completed"), new objj_ivar("_description"), new objj_ivar("_URL")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("ID"), function $Task__ID(self, _cmd)
{ with(self)
{
return _id;
}
},["id"]),
new objj_method(sel_getUid("setID:"), function $Task__setID_(self, _cmd, newValue)
{ with(self)
{
_id = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("isCompleted"), function $Task__isCompleted(self, _cmd)
{ with(self)
{
return _completed;
}
},["id"]),
new objj_method(sel_getUid("setCompleted:"), function $Task__setCompleted_(self, _cmd, newValue)
{ with(self)
{
_completed = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("task"), function $Task__task(self, _cmd)
{ with(self)
{
return _description;
}
},["id"]),
new objj_method(sel_getUid("setTask:"), function $Task__setTask_(self, _cmd, newValue)
{ with(self)
{
_description = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("URL"), function $Task__URL(self, _cmd)
{ with(self)
{
return _URL;
}
},["id"]), new objj_method(sel_getUid("deleteRequest"), function $Task__deleteRequest(self, _cmd)
{ with(self)
{
 var request = objj_msgSend(CPURLRequest, "requestWithURL:", objj_msgSend(self, "URL"));
 objj_msgSend(request, "setHTTPMethod:", "DELETE");
 objj_msgSend(request, "setValue:forHTTPHeaderField:", "no-cache", "Cache-Control");
 return request;
}
},["CPURLRequest"]), new objj_method(sel_getUid("updateRequestWithHTTPBody:"), function $Task__updateRequestWithHTTPBody_(self, _cmd, bodyString)
{ with(self)
{
 var request = objj_msgSend(CPURLRequest, "requestWithURL:", objj_msgSend(self, "URL"));
 objj_msgSend(request, "setHTTPMethod:", "PUT");
 objj_msgSend(request, "setValue:forHTTPHeaderField:", "application/json", "Content-Type");
 objj_msgSend(request, "setValue:forHTTPHeaderField:", "no-cache", "Cache-Control");
 objj_msgSend(request, "setHTTPBody:", bodyString);
 return request;
}
},["CPURLRequest","CPString"]), new objj_method(sel_getUid("JSONString"), function $Task__JSONString(self, _cmd)
{ with(self)
{
 var task = {
  'completed':objj_msgSend(self, "isCompleted"),
  'description':objj_msgSend(self, "task"),
  'id':objj_msgSend(self, "ID"),
  '_id':self.__id
 };
 return objj_msgSend(CPString, "JSONFromObject:", task);
}
},["CPString"]), new objj_method(sel_getUid("toggleCompleted"), function $Task__toggleCompleted(self, _cmd)
{ with(self)
{
 self._completed = !self._completed;
}
},["void"])]);
class_addMethods(meta_class, [new objj_method(sel_getUid("taskFromJSObject:"), function $Task__taskFromJSObject_(self, _cmd, anObject)
{ with(self)
{
 if (typeof(anObject)==="string") {
  anObject = JSON.parse(anObject);
 }
 if (anObject._id != undefined && anObject.id != undefined) {
  var task = objj_msgSend(objj_msgSend(Task, "alloc"), "init");
  task.__id = anObject._id;
  objj_msgSend(task, "setID:", anObject.id);
  objj_msgSend(task, "setCompleted:",  anObject.completed ? YES : NO);
  objj_msgSend(task, "setTask:", (anObject.description || anObject.task || ""));
  task._URL = objj_msgSend(CPURL, "URLWithString:", "/task/"+objj_msgSend(task, "ID"));
  return task;
 } else {


  return nil;
 }
}
},["Task","JSObject"]), new objj_method(sel_getUid("taskWithTask:"), function $Task__taskWithTask_(self, _cmd, aTask)
{ with(self)
{
 var task = {'description':aTask, 'completed':false, 'id':"", '_id':""};
 return objj_msgSend(Task, "taskFromJSObject:", task);
}
},["Task","CPString"])]);
}

