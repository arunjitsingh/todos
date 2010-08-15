@STATIC;1.0;I;21;Foundation/CPObject.jI;15;AppKit/CPView.ji;7;Todos.ji;6;Task.ji;16;RESTConnection.jt;7658;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPView.j",NO);
objj_executeFile("Todos.j",YES);
objj_executeFile("Task.j",YES);
objj_executeFile("RESTConnection.j",YES);
var _1=objj_getClass("CPCollectionView");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"CPCollectionView\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("selectedItems"),function(_3,_4){
with(_3){
var _5=objj_msgSend(_3,"selectionIndexes"),_6=objj_msgSend(_5,"firstIndex"),_7=objj_msgSend(CPSet,"set");
while(_6!==CPNotFound){
objj_msgSend(_7,"addObject:",objj_msgSend(_3,"itemAtIndex:",_6));
_6=objj_msgSend(_5,"indexGreaterThanIndex:",_6);
}
return _7;
}
})]);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("tasksList"),new objj_ivar("tasksConnection")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_8,_9,_a){
with(_8){
var _b=objj_msgSend(objj_msgSend(CPWindow,"alloc"),"initWithContentRect:styleMask:",CGRectMakeZero(),CPBorderlessBridgeWindowMask),_c=objj_msgSend(_b,"contentView");
var _d=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(10,10,90,25));
objj_msgSend(_d,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
objj_msgSend(_d,"setTitle:","Fetch");
objj_msgSend(_d,"setAction:",sel_getUid("fetchTasks:"));
objj_msgSend(_c,"addSubview:",_d);
var _e=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(110,10,90,25));
objj_msgSend(_e,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
objj_msgSend(_e,"setTitle:","New");
objj_msgSend(_e,"setAction:",sel_getUid("createTask:"));
objj_msgSend(_c,"addSubview:",_e);
var _f=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(210,10,90,25));
objj_msgSend(_f,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
objj_msgSend(_f,"setTitle:","Delete");
objj_msgSend(_f,"setAction:",sel_getUid("deleteTasks:"));
objj_msgSend(_c,"addSubview:",_f);
var _10=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(310,10,90,25));
objj_msgSend(_10,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12));
objj_msgSend(_10,"setTitle:","Edit");
objj_msgSend(_10,"setAction:",sel_getUid("updateTask:"));
objj_msgSend(_c,"addSubview:",_10);
var _11=objj_msgSend(objj_msgSend(CPScrollView,"alloc"),"initWithFrame:",CGRectMake(0,40,CGRectGetWidth(objj_msgSend(_c,"bounds")),CGRectGetHeight(objj_msgSend(_c,"bounds"))-40));
objj_msgSend(_11,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(_11,"setAutohidesScrollers:",YES);
objj_msgSend(_c,"addSubview:",_11);
var _12=objj_msgSend(objj_msgSend(CPCollectionViewItem,"alloc"),"init");
objj_msgSend(_12,"setView:",objj_msgSend(objj_msgSend(TaskViewCell,"alloc"),"initWithFrame:",CGRectMakeZero()));
tasksList=objj_msgSend(objj_msgSend(CPCollectionView,"alloc"),"initWithFrame:",CGRectMake(0,0,CGRectGetWidth(objj_msgSend(_c,"bounds")),25));
objj_msgSend(tasksList,"setDelegate:",_8);
objj_msgSend(tasksList,"setItemPrototype:",_12);
objj_msgSend(tasksList,"setMinItemSize:",CGSizeMake(CGRectGetWidth(objj_msgSend(_c,"bounds"))-20,25));
objj_msgSend(tasksList,"setMaxItemSize:",CGSizeMake(CGRectGetWidth(objj_msgSend(_c,"bounds"))-20,25));
objj_msgSend(tasksList,"setAutoresizingMask:",CPViewWidthSizable);
objj_msgSend(tasksList,"setAllowsMultipleSelection:",YES);
objj_msgSend(_11,"setDocumentView:",tasksList);
tasksConnection=objj_msgSend(RESTConnection,"new");
objj_msgSend(_b,"orderFront:",_8);
}
}),new objj_method(sel_getUid("renderResults:"),function(_13,_14,_15){
with(_13){
objj_msgSend(tasksList,"setContent:",_15);
objj_msgSend(tasksList,"reloadContent");
}
}),new objj_method(sel_getUid("didFetchData:"),function(_16,_17,_18){
with(_16){
_18=objj_msgSend(_18,"objectFromJSON");
if(_18.status&&typeof (_18.results)!=="undefined"){
objj_msgSend(_16,"renderResults:",_18.results);
}
}
}),new objj_method(sel_getUid("didUpdateData:"),function(_19,_1a,_1b){
with(_19){
_1b=objj_msgSend(_1b,"objectFromJSON");
if(_1b.status){
objj_msgSend(_19,"fetchTasks:",nil);
}
}
}),new objj_method(sel_getUid("fetchTasks:"),function(_1c,_1d,_1e){
with(_1c){
objj_msgSend(tasksConnection,"setGETConnection:",objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",objj_msgSend(Todos,"fetchRequest"),_1c));
}
}),new objj_method(sel_getUid("createTask:"),function(_1f,_20,_21){
with(_1f){
var _22=prompt("Enter task description: ");
if(_22&&_22.length){
var _23=objj_msgSend(Task,"taskWithTask:",_22);
objj_msgSend(tasksConnection,"setPOSTConnection:",objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",objj_msgSend(Todos,"createRequestWithHTTPBody:",objj_msgSend(_23,"JSONString")),_1f));
}
}
}),new objj_method(sel_getUid("deleteTasks:"),function(_24,_25,_26){
with(_24){
var _27=objj_msgSend(objj_msgSend(tasksList,"selectedItems"),"allObjects"),_28=objj_msgSend(_27,"count");
while(_28--){
var _29=objj_msgSend(_27,"objectAtIndex:",_28),_2a=objj_msgSend(Task,"taskFromJSObject:",objj_msgSend(_29,"representedObject"));
objj_msgSend(tasksConnection,"setDELETEConnection:",objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",objj_msgSend(_2a,"deleteRequest"),_24));
}
}
}),new objj_method(sel_getUid("updateTask:"),function(_2b,_2c,_2d){
with(_2b){
var _2e=objj_msgSend(objj_msgSend(tasksList,"selectedItems"),"allObjects"),_2f=objj_msgSend(_2e,"count");
while(_2f--){
var _30=objj_msgSend(_2e,"objectAtIndex:",_2f),_31=objj_msgSend(Task,"taskFromJSObject:",objj_msgSend(_30,"representedObject")),_32=prompt("Enter task description: ",objj_msgSend(_31,"task"));
if(_32&&_32.length){
objj_msgSend(_31,"setTask:",_32);
objj_msgSend(tasksConnection,"setPUTConnection:",objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",objj_msgSend(_31,"updateRequestWithHTTPBody:",objj_msgSend(_31,"JSONString")),_2b));
}
}
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_33,_34,_35,_36){
with(_33){
if(_35==objj_msgSend(tasksConnection,"GETConnection")){
objj_msgSend(_33,"didFetchData:",_36);
}else{
objj_msgSend(_33,"didUpdateData:",_36);
}
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_37,_38,_39,_3a){
with(_37){
alert(_3a);
}
})]);
var _1=objj_allocateClassPair(CPView,"TaskViewCell"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_label"),new objj_ivar("task")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("task"),function(_3b,_3c){
with(_3b){
return task;
}
}),new objj_method(sel_getUid("setTask:"),function(_3d,_3e,_3f){
with(_3d){
task=_3f;
}
}),new objj_method(sel_getUid("setRepresentedObject:"),function(_40,_41,_42){
with(_40){
task=objj_msgSend(Task,"taskFromJSObject:",_42);
if(!_label){
_label=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMakeZero());
objj_msgSend(_label,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",14));
objj_msgSend(_label,"setFrameOrigin:",CGPointMake(10,2));
objj_msgSend(_label,"setLineBreakMode:",CPLineBreakByWordWrapping);
objj_msgSend(_40,"addSubview:",_label);
}
if(objj_msgSend(task,"isCompleted")){
objj_msgSend(_label,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
}
objj_msgSend(_label,"setStringValue:",objj_msgSend(task,"task"));
objj_msgSend(_label,"sizeToFit");
}
}),new objj_method(sel_getUid("setSelected:"),function(_43,_44,_45){
with(_43){
objj_msgSend(_43,"setBackgroundColor:",(_45?objj_msgSend(CPColor,"blueColor"):nil));
objj_msgSend(_label,"setTextColor:",(_45?objj_msgSend(CPColor,"whiteColor"):objj_msgSend(CPColor,"blackColor")));
}
})]);
