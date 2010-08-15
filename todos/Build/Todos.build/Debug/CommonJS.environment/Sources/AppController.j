@STATIC;1.0;I;21;Foundation/CPObject.jI;15;AppKit/CPView.ji;7;Todos.ji;6;Task.ji;16;RESTConnection.jt;11764;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("AppKit/CPView.j", NO);
objj_executeFile("Todos.j", YES);
objj_executeFile("Task.j", YES);
objj_executeFile("RESTConnection.j", YES);
{
var the_class = objj_getClass("CPCollectionView")
if(!the_class) throw new SyntaxError("*** Could not find definition for class \"CPCollectionView\"");
var meta_class = the_class.isa;class_addMethods(the_class, [new objj_method(sel_getUid("selectedItems"), function $CPCollectionView__selectedItems(self, _cmd)
{ with(self)
{
 var indexes = objj_msgSend(self, "selectionIndexes"),
  index = objj_msgSend(indexes, "firstIndex"),
     set = objj_msgSend(CPSet, "set");
 while (index !== CPNotFound) {
  objj_msgSend(set, "addObject:", objj_msgSend(self, "itemAtIndex:", index));
  index = objj_msgSend(indexes, "indexGreaterThanIndex:", index);
 }
 return set;
}
},["CPSet"])]);
}
{
var the_class = objj_getClass("CPArray")
if(!the_class) throw new SyntaxError("*** Could not find definition for class \"CPArray\"");
var meta_class = the_class.isa;class_addMethods(the_class, [new objj_method(sel_getUid("mutateObjectsByPerformingSelector:"), function $CPArray__mutateObjectsByPerformingSelector_(self, _cmd, aSelector)
{ with(self)
{
 if (!aSelector) {
  objj_msgSend(CPException, "raise:reason:", CPInvalidArgumentException, "mutateObjectsByPerformingSelector: 'aSelector' can't be nil");
 }
 var index = 0,
  count = objj_msgSend(self, "count");
 for(; index < count; ++index) {
  self[index] = objj_msgSend(self[index], aSelector);
 }
}
},["void","SEL"])]);
}
var sortTasksByID = function(lhs, rhs, ctx) {
 var LHS = parseInt(lhs.id, 36),
  RHS = parseInt(rhs.id, 36);
 if (LHS < RHS) {
  return CPOrderedAscending;
 } else if (LHS > RHS) {
        return CPOrderedDescending;
 }
    return CPOrderedSame;
}
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("tasksList"), new objj_ivar("tasksConnection")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{ with(self)
{
    var theWindow = objj_msgSend(objj_msgSend(CPWindow, "alloc"), "initWithContentRect:styleMask:", CGRectMakeZero(), CPBorderlessBridgeWindowMask),
        contentView = objj_msgSend(theWindow, "contentView");
    var fetchButton = objj_msgSend(objj_msgSend(CPButton, "alloc"), "initWithFrame:", CGRectMake(10.0, 10.0, 90.0, 25.0));
 objj_msgSend(fetchButton, "setFont:", objj_msgSend(CPFont, "boldSystemFontOfSize:", 12.0));
 objj_msgSend(fetchButton, "setTitle:", "Fetch");
 objj_msgSend(fetchButton, "setAction:", sel_getUid("fetchTasks:"));
 objj_msgSend(contentView, "addSubview:", fetchButton);
 var createButton = objj_msgSend(objj_msgSend(CPButton, "alloc"), "initWithFrame:", CGRectMake(110.0, 10.0, 90.0, 25.0));
 objj_msgSend(createButton, "setFont:", objj_msgSend(CPFont, "boldSystemFontOfSize:", 12.0));
 objj_msgSend(createButton, "setTitle:", "New");
 objj_msgSend(createButton, "setAction:", sel_getUid("createTask:"));
 objj_msgSend(contentView, "addSubview:", createButton);
 var deleteButton = objj_msgSend(objj_msgSend(CPButton, "alloc"), "initWithFrame:", CGRectMake(210.0, 10.0, 90.0, 25.0));
 objj_msgSend(deleteButton, "setFont:", objj_msgSend(CPFont, "boldSystemFontOfSize:", 12.0));
 objj_msgSend(deleteButton, "setTitle:", "Delete");
 objj_msgSend(deleteButton, "setAction:", sel_getUid("deleteTasks:"));
 objj_msgSend(contentView, "addSubview:", deleteButton);
 var editButton = objj_msgSend(objj_msgSend(CPButton, "alloc"), "initWithFrame:", CGRectMake(310.0, 10.0, 90.0, 25.0));
 objj_msgSend(editButton, "setTag:", 0);
 objj_msgSend(editButton, "setFont:", objj_msgSend(CPFont, "boldSystemFontOfSize:", 12.0));
 objj_msgSend(editButton, "setTitle:", "Edit");
 objj_msgSend(editButton, "setAction:", sel_getUid("updateTask:"));
 objj_msgSend(contentView, "addSubview:", editButton);
 var doneButton = objj_msgSend(objj_msgSend(CPButton, "alloc"), "initWithFrame:", CGRectMake(410.0, 10.0, 110.0, 25.0));
 objj_msgSend(doneButton, "setTag:", 1);
 objj_msgSend(doneButton, "setFont:", objj_msgSend(CPFont, "boldSystemFontOfSize:", 12.0));
 objj_msgSend(doneButton, "setTitle:", "Toggle Done");
 objj_msgSend(doneButton, "setAction:", sel_getUid("updateTask:"));
 objj_msgSend(contentView, "addSubview:", doneButton);
 var resultsArea = objj_msgSend(objj_msgSend(CPScrollView, "alloc"), "initWithFrame:", CGRectMake(0.0, 40.0,
               CGRectGetWidth(objj_msgSend(contentView, "bounds")),
               CGRectGetHeight(objj_msgSend(contentView, "bounds")) - 40.0));
 objj_msgSend(resultsArea, "setAutoresizingMask:", CPViewWidthSizable | CPViewHeightSizable);
 objj_msgSend(resultsArea, "setAutohidesScrollers:", YES);
 objj_msgSend(contentView, "addSubview:", resultsArea);
 var taskItem = objj_msgSend(objj_msgSend(CPCollectionViewItem, "alloc"), "init");
 objj_msgSend(taskItem, "setView:", objj_msgSend(objj_msgSend(TaskViewCell, "alloc"), "initWithFrame:", CGRectMakeZero()));
 tasksList = objj_msgSend(objj_msgSend(CPCollectionView, "alloc"), "initWithFrame:", CGRectMake(0,0,
               CGRectGetWidth(objj_msgSend(contentView, "bounds")),
               25.0));
 objj_msgSend(tasksList, "setDelegate:", self);
 objj_msgSend(tasksList, "setItemPrototype:", taskItem);
 objj_msgSend(tasksList, "setMinItemSize:", CGSizeMake(CGRectGetWidth(objj_msgSend(contentView, "bounds"))-20.0, 25.0));
 objj_msgSend(tasksList, "setMaxItemSize:", CGSizeMake(CGRectGetWidth(objj_msgSend(contentView, "bounds"))-20.0, 25.0));
 objj_msgSend(tasksList, "setAutoresizingMask:", CPViewWidthSizable);
 objj_msgSend(tasksList, "setAllowsMultipleSelection:", YES);
 objj_msgSend(resultsArea, "setDocumentView:", tasksList);
 tasksConnection = objj_msgSend(RESTConnection, "new");
    objj_msgSend(theWindow, "orderFront:", self);
}
},["void","CPNotification"]), new objj_method(sel_getUid("renderResults:"), function $AppController__renderResults_(self, _cmd, results)
{ with(self)
{
 objj_msgSend(results, "mutateObjectsByPerformingSelector:", sel_getUid("objectFromJSON"));
 objj_msgSend(results, "sortUsingFunction:context:", sortTasksByID, nil)
 objj_msgSend(tasksList, "setContent:", results);
 objj_msgSend(tasksList, "reloadContent");
}
},["void","CPArray"]), new objj_method(sel_getUid("didFetchData:"), function $AppController__didFetchData_(self, _cmd, data)
{ with(self)
{
 data = objj_msgSend(data, "objectFromJSON");
 if (data.status && typeof(data.results) !== "undefined") {
  objj_msgSend(self, "renderResults:", data.results);
 }
}
},["void","CPString"]), new objj_method(sel_getUid("didUpdateData:"), function $AppController__didUpdateData_(self, _cmd, data)
{ with(self)
{
 data = objj_msgSend(data, "objectFromJSON");
 if (data.status) {
  objj_msgSend(self, "fetchTasks:", nil);
 }
}
},["void","CPString"]), new objj_method(sel_getUid("fetchTasks:"), function $AppController__fetchTasks_(self, _cmd, sender)
{ with(self)
{
 objj_msgSend(tasksConnection, "setGETConnection:", 
  objj_msgSend(CPURLConnection, "connectionWithRequest:delegate:", objj_msgSend(Todos, "fetchRequest"), self));
}
},["void","id"]), new objj_method(sel_getUid("createTask:"), function $AppController__createTask_(self, _cmd, sender)
{ with(self)
{
 var desc = prompt("Enter task description: ");
 if (desc && desc.length) {
  var task = objj_msgSend(Task, "taskWithTask:", desc);
  objj_msgSend(tasksConnection, "setPOSTConnection:", 
   objj_msgSend(CPURLConnection, "connectionWithRequest:delegate:", objj_msgSend(Todos, "createRequestWithHTTPBody:", objj_msgSend(task, "JSONString")), self));
 }
}
},["void","id"]), new objj_method(sel_getUid("deleteTasks:"), function $AppController__deleteTasks_(self, _cmd, sender)
{ with(self)
{
 var selectedItems = objj_msgSend(objj_msgSend(tasksList, "selectedItems"), "allObjects"),
  count = objj_msgSend(selectedItems, "count");
 while (count--) {
  var taskItem = objj_msgSend(selectedItems, "objectAtIndex:", count),
   task = objj_msgSend(Task, "taskFromJSObject:", objj_msgSend(taskItem, "representedObject"));
  objj_msgSend(tasksConnection, "setDELETEConnection:", 
     objj_msgSend(CPURLConnection, "connectionWithRequest:delegate:", objj_msgSend(task, "deleteRequest"), self));
 }
}
},["void","id"]), new objj_method(sel_getUid("updateTask:"), function $AppController__updateTask_(self, _cmd, sender)
{ with(self)
{
 var selectedItems = objj_msgSend(objj_msgSend(tasksList, "selectedItems"), "allObjects"),
  count = objj_msgSend(selectedItems, "count");
 while (count--) {
  var taskItem = objj_msgSend(selectedItems, "objectAtIndex:", count),
   task = objj_msgSend(Task, "taskFromJSObject:", objj_msgSend(taskItem, "representedObject")),
   requiresUpdate = NO;
  if (objj_msgSend(sender, "tag") == 0) {
      var desc = prompt("Enter task description: ", objj_msgSend(task, "task"));
   if (desc && desc.length) {
    objj_msgSend(task, "setTask:", desc);
    requiredUpdate = YES;
   }
  } else {
   objj_msgSend(task, "toggleCompleted");
   requiresUpdate = YES;
  }
  if (requiresUpdate) {
   objj_msgSend(tasksConnection, "setPUTConnection:", 
    objj_msgSend(CPURLConnection, "connectionWithRequest:delegate:", objj_msgSend(task, "updateRequestWithHTTPBody:", objj_msgSend(task, "JSONString")), self));
  }
 }
}
},["void","id"]), new objj_method(sel_getUid("connection:didReceiveData:"), function $AppController__connection_didReceiveData_(self, _cmd, aConnection, data)
{ with(self)
{
 if (aConnection == objj_msgSend(tasksConnection, "GETConnection")) {
  objj_msgSend(self, "didFetchData:", data);
 } else {
  objj_msgSend(self, "didUpdateData:", data);
 }
}
},["void","CPURLConnection","CPString"]), new objj_method(sel_getUid("connection:didFailWithError:"), function $AppController__connection_didFailWithError_(self, _cmd, aConnection, error)
{ with(self)
{
 alert(error);
}
},["void","CPURLConnection","CPString"])]);
}
{var the_class = objj_allocateClassPair(CPView, "TaskViewCell"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_label"), new objj_ivar("task")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("task"), function $TaskViewCell__task(self, _cmd)
{ with(self)
{
return task;
}
},["id"]),
new objj_method(sel_getUid("setTask:"), function $TaskViewCell__setTask_(self, _cmd, newValue)
{ with(self)
{
task = newValue;
}
},["void","id"]), new objj_method(sel_getUid("setRepresentedObject:"), function $TaskViewCell__setRepresentedObject_(self, _cmd, anObject)
{ with(self)
{
 task = objj_msgSend(Task, "taskFromJSObject:", anObject);
 if (!_label) {
  _label = objj_msgSend(objj_msgSend(CPTextField, "alloc"), "initWithFrame:", CGRectMakeZero());
  objj_msgSend(_label, "setFrameOrigin:", CGPointMake(10.0, 2.0));
  objj_msgSend(_label, "setLineBreakMode:", CPLineBreakByWordWrapping);
  objj_msgSend(self, "addSubview:", _label);
 }
 if (objj_msgSend(task, "isCompleted")) {
  objj_msgSend(_label, "setFont:", objj_msgSend(CPFont, "systemFontOfSize:", 14.0));
 } else {
  objj_msgSend(_label, "setFont:", objj_msgSend(CPFont, "boldSystemFontOfSize:", 14.0));
 }
 objj_msgSend(_label, "setStringValue:", objj_msgSend(task, "task"));
 objj_msgSend(_label, "sizeToFit");
}
},["void","JSObject"]), new objj_method(sel_getUid("setSelected:"), function $TaskViewCell__setSelected_(self, _cmd, isSelected)
{ with(self)
{
 objj_msgSend(self, "setBackgroundColor:", (isSelected ? objj_msgSend(CPColor, "blueColor") : nil));
 objj_msgSend(_label, "setTextColor:", (isSelected ? objj_msgSend(CPColor, "whiteColor") : objj_msgSend(CPColor, "blackColor")));
}
},["void","BOOL"])]);
}

