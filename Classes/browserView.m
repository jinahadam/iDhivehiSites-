//
//  browserView.m
//  iDhivehiSites
//
//  Created by Jinah Adam on 7/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "browserView.h"

@interface NSString (Utilities)
- (NSString *) URLEncodedString_ch;
@end

@implementation NSString (Utilities)

- (NSString *) URLEncodedString_ch {
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' || 
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}


@end


@implementation browserView




@synthesize webView;
@synthesize url,home,backward,forward,siteName,currentURL;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */
- (void)webViewDidFinishLoad:(UIWebView *) webview {
    
	NSURLRequest *currentRequest = [webview request];
	currentURL = [currentRequest URL];
	//NSLog(@"Current URL is %@", currentURL.absoluteString);
	
}


-(IBAction) goHome {
	[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//NSLog(url);
		
	self.title = @" ";
	
	
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
											[NSArray arrayWithObjects:@"<",@">",
											 nil]];
	
	[segmentedControl addTarget:self
						 action:@selector(pickOne:)
			   forControlEvents:UIControlEventValueChanged];
	
	
	//[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.frame = CGRectMake(0, 0, 130, 30);
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.momentary = YES;
	
	UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
	[segmentedControl release];
    
	self.navigationItem.rightBarButtonItem = segmentBarItem;
	[segmentBarItem release];
	
	
	
	
	//NSURL *nsurl = [NSURL URLWithString:url];
	
	
	//NSURLRequest *requestObj = [NSURLRequest requestWithURL:nsurl];
	
	//Load the request in the UIWebView.
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
	webView.multipleTouchEnabled = YES;
	[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkLoad) userInfo:nil repeats:YES];
	[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkNotLoad) userInfo:nil repeats:YES];
	
}

- (void) pickOne:(id)sender{
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	NSString *selected = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
	
	if([selected isEqualToString:@"<"]) {
		[webView goBack];
		
	} else if ([selected isEqualToString:@">"]) {
		
		[webView goForward];
		
	} else {
		

		
		/*
		NSString *e = currentURL.absoluteString;
		MKBitlyHelper *bitlyHelper = [[MKBitlyHelper alloc] initWithLoginName:@"jinahadam" andAPIKey:@"R_e90688e7f10d7eee0e8eb7c007e094dc"];
		NSString *shortURL = [bitlyHelper shortenURL:e];
		
		
		
		[[TwitterAgent defaultAgent] twit ];
		[[TwitterAgent defaultAgent] twit:@"Breaking!" withLink:[NSString stringWithFormat:@"%@ #iDhivehiSites", shortURL] makeTiny:NO];
		
		//NSLog(shortURL);
		 */
		
	}
	
}




- (void)checkLoad {
	if (webView.loading) {
		UIApplication* app = [UIApplication sharedApplication];
		app.networkActivityIndicatorVisible = YES; 
        
	}
}
- (void)checkNotLoad {
	if (!(webView.loading)) {
		UIApplication* app = [UIApplication sharedApplication];
		app.networkActivityIndicatorVisible = NO; 	
        NSLog(@"%@", currentURL);
    
    }
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	if((self.interfaceOrientation == UIDeviceOrientationLandscapeLeft) || (self.interfaceOrientation == UIDeviceOrientationLandscapeRight)){
		
		
		webView.scalesPageToFit = YES;
		
		
	} else	if((self.interfaceOrientation == UIDeviceOrientationPortrait) || (self.interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)){
		
		
		webView.scalesPageToFit = YES;
		
		
	}
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
