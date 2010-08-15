@STATIC;1.0;I;21;Foundation/CPObject.jt;1582;

objj_executeFile("Foundation/CPObject.j", NO);

{var the_class = objj_allocateClassPair(CPObject, "RESTConnection"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_GET"), new objj_ivar("_POST"), new objj_ivar("_PUT"), new objj_ivar("_DELETE")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("GETConnection"), function $RESTConnection__GETConnection(self, _cmd)
{ with(self)
{
return _GET;
}
},["id"]),
new objj_method(sel_getUid("setGETConnection:"), function $RESTConnection__setGETConnection_(self, _cmd, newValue)
{ with(self)
{
_GET = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("POSTConnection"), function $RESTConnection__POSTConnection(self, _cmd)
{ with(self)
{
return _POST;
}
},["id"]),
new objj_method(sel_getUid("setPOSTConnection:"), function $RESTConnection__setPOSTConnection_(self, _cmd, newValue)
{ with(self)
{
_POST = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("PUTConnection"), function $RESTConnection__PUTConnection(self, _cmd)
{ with(self)
{
return _PUT;
}
},["id"]),
new objj_method(sel_getUid("setPUTConnection:"), function $RESTConnection__setPUTConnection_(self, _cmd, newValue)
{ with(self)
{
_PUT = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("DELETEConnection"), function $RESTConnection__DELETEConnection(self, _cmd)
{ with(self)
{
return _DELETE;
}
},["id"]),
new objj_method(sel_getUid("setDELETEConnection:"), function $RESTConnection__setDELETEConnection_(self, _cmd, newValue)
{ with(self)
{
_DELETE = newValue;
}
},["void","id"])]);
}