@import <Foundation/CPObject.j>

@implementation RESTConnection : CPObject {
	CPURLConnection		_GET	@accessors(property=GETConnection);
	CPURLConnection		_POST	@accessors(property=POSTConnection);
	CPURLConnection		_PUT	@accessors(property=PUTConnection);
	CPURLConnection		_DELETE	@accessors(property=DELETEConnection);
}