@STATIC;1.0;I;21;Foundation/CPObject.jt;1032;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"RESTConnection"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_GET"),new objj_ivar("_POST"),new objj_ivar("_PUT"),new objj_ivar("_DELETE")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("GETConnection"),function(_3,_4){
with(_3){
return _GET;
}
}),new objj_method(sel_getUid("setGETConnection:"),function(_5,_6,_7){
with(_5){
_GET=_7;
}
}),new objj_method(sel_getUid("POSTConnection"),function(_8,_9){
with(_8){
return _POST;
}
}),new objj_method(sel_getUid("setPOSTConnection:"),function(_a,_b,_c){
with(_a){
_POST=_c;
}
}),new objj_method(sel_getUid("PUTConnection"),function(_d,_e){
with(_d){
return _PUT;
}
}),new objj_method(sel_getUid("setPUTConnection:"),function(_f,_10,_11){
with(_f){
_PUT=_11;
}
}),new objj_method(sel_getUid("DELETEConnection"),function(_12,_13){
with(_12){
return _DELETE;
}
}),new objj_method(sel_getUid("setDELETEConnection:"),function(_14,_15,_16){
with(_14){
_DELETE=_16;
}
})]);
