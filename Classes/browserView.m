//
//  browserView.m
//  iDhivehiSites
//
//  Created by Jinah Adam on 7/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "browserView.h"
#import "TwitterAgent.h"

@implementation browserView


@synthesize webView;
@synthesize url,home,backward,forward,siteName;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


-(IBAction) goHome {
	[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//NSLog(url);
	
	self.title = siteName;
	
	
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
											[NSArray arrayWithObjects:@"<",@">",@"Share",
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
		
		NSString *sURL = webView.request.URL.absoluteString;
		
		[[TwitterAgent defaultAgent] twit ];
		
		NSLog(sURL);
		
		[[TwitterAgent defaultAgent] twit:@"News!" withLink:[NSString stringWithFormat:@"%@ #iDhivehiSites", sURL] makeTiny:NO];
		
		
		
	}

}




- (void)checkLoad {
	if (webView.loading) {
		active.hidden = NO;
		[active startAnimating];
	}
}
- (void)checkNotLoad {
	if (!(webView.loading)) {
		active.hidden = YES;
		[active stopAnimating];
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
