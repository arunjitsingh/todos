@STATIC;1.0;I;21;Foundation/CPObject.jt;2638;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"Task"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("__id"),new objj_ivar("_id"),new objj_ivar("_completed"),new objj_ivar("_description"),new objj_ivar("_URL")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("ID"),function(_3,_4){
with(_3){
return _id;
}
}),new objj_method(sel_getUid("setID:"),function(_5,_6,_7){
with(_5){
_id=_7;
}
}),new objj_method(sel_getUid("isCompleted"),function(_8,_9){
with(_8){
return _completed;
}
}),new objj_method(sel_getUid("setCompleted:"),function(_a,_b,_c){
with(_a){
_completed=_c;
}
}),new objj_method(sel_getUid("task"),function(_d,_e){
with(_d){
return _description;
}
}),new objj_method(sel_getUid("setTask:"),function(_f,_10,_11){
with(_f){
_description=_11;
}
}),new objj_method(sel_getUid("URL"),function(_12,_13){
with(_12){
return _URL;
}
}),new objj_method(sel_getUid("deleteRequest"),function(_14,_15){
with(_14){
var _16=objj_msgSend(CPURLRequest,"requestWithURL:",objj_msgSend(_14,"URL"));
objj_msgSend(_16,"setHTTPMethod:","DELETE");
objj_msgSend(_16,"setValue:forHTTPHeaderField:","no-cache","Cache-Control");
return _16;
}
}),new objj_method(sel_getUid("updateRequestWithHTTPBody:"),function(_17,_18,_19){
with(_17){
var _1a=objj_msgSend(CPURLRequest,"requestWithURL:",objj_msgSend(_17,"URL"));
objj_msgSend(_1a,"setHTTPMethod:","PUT");
objj_msgSend(_1a,"setValue:forHTTPHeaderField:","application/json","Content-Type");
objj_msgSend(_1a,"setValue:forHTTPHeaderField:","no-cache","Cache-Control");
objj_msgSend(_1a,"setHTTPBody:",_19);
return _1a;
}
}),new objj_method(sel_getUid("JSONString"),function(_1b,_1c){
with(_1b){
var _1d={"completed":objj_msgSend(_1b,"isCompleted"),"description":objj_msgSend(_1b,"task"),"id":objj_msgSend(_1b,"ID"),"_id":_1b.__id};
return objj_msgSend(CPString,"JSONFromObject:",_1d);
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("taskFromJSObject:"),function(_1e,_1f,_20){
with(_1e){
if(typeof (_20)==="string"){
_20=JSON.parse(_20);
}
if(_20._id!=undefined&&_20.id!=undefined){
var _21=objj_msgSend(objj_msgSend(Task,"alloc"),"init");
_21.__id=_20._id;
objj_msgSend(_21,"setID:",_20.id);
objj_msgSend(_21,"setCompleted:",_20.completed?YES:NO);
objj_msgSend(_21,"setTask:",(_20.description||_20.task||""));
_21._URL=objj_msgSend(CPURL,"URLWithString:","/task/"+objj_msgSend(_21,"ID"));
return _21;
}else{
return nil;
}
}
}),new objj_method(sel_getUid("taskWithTask:"),function(_22,_23,_24){
with(_22){
var _25={"description":_24,"completed":false,"id":"","_id":""};
return objj_msgSend(Task,"taskFromJSObject:",_25);
}
})]);
