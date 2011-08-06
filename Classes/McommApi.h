//
//  McommApi.h
//  ApiSample
//
//  Copyright 2011 mComm360. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol McommDelegate
- (void) requestDidFail:(NSError*) error;
- (void) requestDidSucceed:(NSDictionary*) response code:(int) code message:(NSString*) message;
@end


@interface McommApi : NSObject {
	NSString* apiKey;
	NSMutableData *responseData;
	NSString* requestMethod;

	id <McommDelegate> delegate;
}

- (McommApi*) init:(NSString*)apiKey delegate: (id) del;

- (void) checkUser:(int) promoid identifier: (NSString*) identifier;
- (void) profile:(int) promoid identifier: (NSString*) identifier;
- (void) deleteUser:(int) promoid identifier: (NSString*) identifier;

- (void) getStoreList:(int) clientId;
- (void) getPromoList:(int) clientId;

- (void) redeem:(int) storeId identifier: (NSString*) identifier user: (NSDictionary*) user;

@end
