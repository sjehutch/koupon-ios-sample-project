//
//  ApiSampleViewController.m
//  ApiSample
//
//  Copyright 2011 mComm360. All rights reserved.
//

#import "ApiSampleViewController.h"

@implementation ApiSampleViewController

@synthesize picker;
@synthesize output;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [methodArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [methodArray objectAtIndex:row];
}

- (IBAction) goTapped {
	int selectedIndex = [picker selectedRowInComponent:0];
	NSString* method = [methodArray objectAtIndex:selectedIndex];
	
	output.text = @"";
	
	if([method isEqualToString:@"redeem"]) {
		NSMutableDictionary* user = [[NSMutableDictionary alloc] init];
		[user setValue:[NSNumber numberWithInt:7] forKey:@"promoid"];
		[user setValue:@"testuser@mydomain.com" forKey:@"email"];
		[user setValue:@"3035551212" forKey:@"mobile_phone"];
		[user setValue:[NSNumber numberWithBool:true] forKey:@"send_sms"];
		
		[api redeem:7 identifier:@"testuser" user:user];
	}
	else if([method isEqualToString:@"checkUser"]) {
		[api checkUser:7 identifier:@"testuser"];
	}
	else if([method isEqualToString:@"profile"]) {
		[api profile:7 identifier:@"testuser"];
	}
	else if([method isEqualToString:@"deleteUser"]) {
		[api deleteUser:7 identifier:@"testuser"];
	}
	else if([method isEqualToString:@"getStoreList"]) {
		[api getStoreList:5];
	}
	else if([method isEqualToString:@"getPromoList"]) {
		[api getPromoList:5];
	}
}

- (void) requestDidFail:(NSError*) error {
	output.text = [NSString stringWithFormat:@"error: %@", [error localizedDescription]];
}

- (void) requestDidSucceed:(NSDictionary*) response code:(int) code message:(NSString*) message {
	
	NSMutableString* result = [[NSMutableString alloc] init];
	
	[result appendFormat:@"code: %d  message: %@\n", code, message];
	[result appendFormat:@"response data: %@", response];

	output.text = result;
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	methodArray = [[NSArray alloc] initWithObjects:
		@"redeem", 
		@"checkUser", 
		@"profile", 
		@"deleteUser", 
		@"getStoreList", 
		@"getPromoList", 
		nil];
	
	api = [[McommApi alloc] init:@"YOUR_API_KEY_HERE" delegate: self];
	[api retain];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[api release];
	[methodArray release];
}

@end
