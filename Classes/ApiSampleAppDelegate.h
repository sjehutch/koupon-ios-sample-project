//
//  ApiSampleAppDelegate.h
//  ApiSample
//
//  Copyright 2011 mComm360. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApiSampleViewController;

@interface ApiSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ApiSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ApiSampleViewController *viewController;

@end

