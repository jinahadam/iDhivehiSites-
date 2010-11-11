//
//  haveeruArticle.m
//  iDhivehiSites
//
//  Created by Jinah Adam on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "haveeruArticle.h"
#import "ASIHTTPRequest.h"




@implementation haveeruArticle

@synthesize aText,aUrl;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//aText.font = [UIFont fontWithName:@"A_Randhoo" size:18];
	//aTitle.font =  [UIFont fontWithName:@"A_Randhoo" size:18];
	
	self.title = @"Haveeru";
	aText.hidden = YES;
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:aUrl]];
	[request setDelegate:self];
	[request startAsynchronous];
	[request setDidFinishSelector:@selector(showArticle:)];
	
	
    [super viewDidLoad];
}

-(void)showArticle:(ASIHTTPRequest *)request {
	
	
	
	aText.hidden = NO;

	[aText loadHTMLString:[request responseString]  baseURL:[NSURL URLWithString:@"http://jinahadam.com/blog"]];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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
