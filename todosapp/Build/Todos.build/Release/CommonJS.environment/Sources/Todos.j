@STATIC;1.0;I;21;Foundation/CPObject.jt;1120;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"Todos"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_2,[new objj_method(sel_getUid("fetchURL"),function(_3,_4){
with(_3){
return objj_msgSend(CPURL,"URLWithString:","/tasks");
}
}),new objj_method(sel_getUid("fetchRequest"),function(_5,_6){
with(_5){
var _7=objj_msgSend(CPURLRequest,"requestWithURL:",objj_msgSend(Todos,"fetchURL"));
objj_msgSend(_7,"setHTTPMethod:","GET");
objj_msgSend(_7,"setValue:forHTTPHeaderField:","no-cache","Cache-Control");
return _7;
}
}),new objj_method(sel_getUid("createURL"),function(_8,_9){
with(_8){
return objj_msgSend(CPURL,"URLWithString:","/task");
}
}),new objj_method(sel_getUid("createRequestWithHTTPBody:"),function(_a,_b,_c){
with(_a){
var _d=objj_msgSend(CPURLRequest,"requestWithURL:",objj_msgSend(Todos,"createURL"));
objj_msgSend(_d,"setValue:forHTTPHeaderField:","application/json","Content-Type");
objj_msgSend(_d,"setValue:forHTTPHeaderField:","no-cache","Cache-Control");
objj_msgSend(_d,"setHTTPMethod:","POST");
objj_msgSend(_d,"setHTTPBody:",_c);
return _d;
}
})]);
