@STATIC;1.0;I;21;Foundation/CPObject.jt;1477;

objj_executeFile("Foundation/CPObject.j", NO);

{var the_class = objj_allocateClassPair(CPObject, "Todos"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(meta_class, [new objj_method(sel_getUid("fetchURL"), function $Todos__fetchURL(self, _cmd)
{ with(self)
{
 return objj_msgSend(CPURL, "URLWithString:", "/tasks");
}
},["CPURL"]), new objj_method(sel_getUid("fetchRequest"), function $Todos__fetchRequest(self, _cmd)
{ with(self)
{
 var request = objj_msgSend(CPURLRequest, "requestWithURL:", objj_msgSend(Todos, "fetchURL"));
 objj_msgSend(request, "setHTTPMethod:", "GET");
 objj_msgSend(request, "setValue:forHTTPHeaderField:", "no-cache", "Cache-Control");
 return request;
}
},["CPURLRequest"]), new objj_method(sel_getUid("createURL"), function $Todos__createURL(self, _cmd)
{ with(self)
{
 return objj_msgSend(CPURL, "URLWithString:", "/task");
}
},["CPURL"]), new objj_method(sel_getUid("createRequestWithHTTPBody:"), function $Todos__createRequestWithHTTPBody_(self, _cmd, bodyString)
{ with(self)
{
 var request = objj_msgSend(CPURLRequest, "requestWithURL:", objj_msgSend(Todos, "createURL"));
 objj_msgSend(request, "setValue:forHTTPHeaderField:", "application/json", "Content-Type");
 objj_msgSend(request, "setValue:forHTTPHeaderField:", "no-cache", "Cache-Control");
 objj_msgSend(request, "setHTTPMethod:", "POST");
 objj_msgSend(request, "setHTTPBody:", bodyString);
 return request;
}
},["CPURLRequest","CPString"])]);
}

