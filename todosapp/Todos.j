@import <Foundation/CPObject.j>

@implementation Todos : CPObject {
}

+ (CPURL)fetchURL {
	return [CPURL URLWithString:@"/tasks"];
}

+ (CPURLRequest)fetchRequest {
	var request = [CPURLRequest requestWithURL:[Todos fetchURL]];
	[request setHTTPMethod:@"GET"];
	[request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	return request;
}

+ (CPURL)createURL {
	return [CPURL URLWithString:@"/task"];
}

+ (CPURLRequest)createRequestWithHTTPBody:(CPString)bodyString {
	var request = [CPURLRequest requestWithURL:[Todos createURL]];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:bodyString];
	return request;
}

@end