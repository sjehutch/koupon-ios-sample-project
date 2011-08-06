//
//  McommApi.m
//  ApiSample
//
//  Copyright 2011 mComm360. All rights reserved.
//

#import "McommApi.h"
#import "SBJSON.h"

@implementation McommApi

NSString* const kBaseUrl = @"http://api.mcomm360.com/userservice.svc";

- (McommApi*) init:(NSString*)key delegate: (id) del; {
	self = [super init];
	if(self) {
		apiKey = key;
		delegate = del;
		responseData = [[NSMutableData data] retain];
	}
	return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[delegate requestDidFail:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSDictionary* dict = [[responseString JSONValue] retain];
	[dict autorelease];

	int code = [[dict objectForKey:@"code"] intValue];
	id msg = [dict objectForKey:@"message"];
	NSString* message = [msg isKindOfClass: [NSString class]] ? msg : nil;
	
	[delegate requestDidSucceed: dict code: code message: message];
}

- (void) sendRequest:(NSString*) urlString method:(NSString*) method body:(NSString*) body {
	NSURL* url = [NSURL URLWithString:urlString];
	NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
	[req setHTTPMethod:method];
	
	if(body != nil) {
		NSString* length = [NSString stringWithFormat:@"%d", [body length]];
		[req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
		[req addValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
		[req addValue: length forHTTPHeaderField:@"Content-Length"];
	}
	
	[[NSURLConnection alloc] initWithRequest:req delegate:self];
}

- (void) sendRequest:(NSString*) urlString {
	return [self sendRequest:urlString method:@"GET" body:nil];
}

- (void) checkUser:(int) promoid identifier: (NSString*) identifier {
	NSString* url = 
		[NSString stringWithFormat:@"%@/checkuser/%@/%d/%@",
		 kBaseUrl, identifier, promoid, apiKey];

	[self sendRequest:url];
}

- (void) profile:(int) promoid identifier: (NSString*) identifier {
	NSString* url = 
	[NSString stringWithFormat:@"%@/profile/%@/%d/%@",
	 kBaseUrl, identifier, promoid, apiKey];
	
	[self sendRequest:url];
}

- (void) deleteUser:(int) promoid identifier: (NSString*) identifier {
	NSString* url = 
	[NSString stringWithFormat:@"%@/deleteuser/%@/%d/%@",
	 kBaseUrl, identifier, promoid, apiKey];
	
	[self sendRequest:url];
}

- (void) getStoreList:(int) clientId {
	NSString* url = 
	[NSString stringWithFormat:@"%@/getstorelist/%d/%@",
	 kBaseUrl, clientId, apiKey];
	
	[self sendRequest:url];
}

- (void) getPromoList:(int) clientId {
	NSString* url = 
	[NSString stringWithFormat:@"%@/getpromolist/%d/%@",
	 kBaseUrl, clientId, apiKey];
	
	[self sendRequest:url];
}

- (void) redeem:(int) storeId identifier: (NSString*) identifier user: (NSDictionary*) user {
	NSString* url = 
	[NSString stringWithFormat:@"%@/redeem/%d/%@/%@",
	 kBaseUrl, storeId, identifier, apiKey];
	
	[self sendRequest:url method: @"PUT" body: [user JSONRepresentation]];
}

- (void)dealloc {
	[responseData release];
    [super dealloc];
}


@end
