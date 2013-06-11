

#import "newSite.h"
#import "browserView.h"

@implementation newSite



@synthesize messageId;
@synthesize name;
@synthesize url;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	self.title = @"Add New";
	
	
    [super viewDidLoad];
		

}

-(IBAction) goBack {
	[self.navigationController popToViewController:(self.navigationController.viewControllers)[0] animated:YES];
}


-(IBAction) saveOnly {
	
	
	NSString *urlstring = [NSString stringWithFormat:@"http://%@",url.text];
	
	if([url.text length] < 2 ) {
		return;
	}
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = paths[0];
	NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"sites.plist"];
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath] ;
	
	NSMutableArray *list = dict[@"dhivehisites"];
	
	NSDictionary *newsite = @{@"site": @[@"globe.png",urlstring,name.text]};
	[list addObject:newsite];
	
	
	dict[@"dhivehisites"] = list;
	
	[dict writeToFile:plistPath atomically:YES];

	
	[self.navigationController popToViewController:(self.navigationController.viewControllers)[0] animated:YES];

}

-(IBAction) saveAndGo {
	NSString *urlstring = [NSString stringWithFormat:@"http://%@",url.text];
	
	if([url.text length] < 2 ) {
		return;
	}
	
	
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = paths[0];
	NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"sites.plist"];
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath] ;
	
	NSMutableArray *list = dict[@"dhivehisites"];
	
	NSDictionary *newsite = @{@"site": @[@"globe.png",urlstring,name.text]};
	[list addObject:newsite];
	
	dict[@"dhivehisites"] = list;
	
	[dict writeToFile:plistPath atomically:YES];

	//UIImage * img = [UIImage imageNamed: @"loading.png"];
	
	//DrillDownWebController * controller = [[DrillDownWebController alloc] initWithWebRoot: urlstring andTitle:@"Loading..." andSplashImage:img];
 	
	//[[self navigationController] pushViewController:controller animated: YES];
	
	//[controller release];
	
	browserView *browser = [[browserView alloc] initWithNibName:@"browserView" bundle:nil];
	
	browser.url = urlstring;
	
	[self.navigationController pushViewController:browser animated:YES];
	
	
	
	
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
