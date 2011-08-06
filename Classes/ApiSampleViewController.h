//
//  ApiSampleViewController.h
//  ApiSample
//
//  Copyright 2011 mComm360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "McommApi.h"

@interface ApiSampleViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	McommApi* api;
	NSArray* methodArray;
	
	IBOutlet UIPickerView* picker;
	IBOutlet UITextView* output;
}

@property (nonatomic, retain) IBOutlet UIPickerView* picker;
@property (nonatomic, retain) IBOutlet UITextView* output;

- (IBAction) goTapped;

@end

