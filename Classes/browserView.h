//
//  browserView.h
//  iDhivehiSites
//
//  Created by Jinah Adam on 7/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface browserView : UIViewController  <UIWebViewDelegate> {
	
		
	
    IBOutlet UIWebView *webView;
	NSString *url;
	IBOutlet UIActivityIndicatorView *active;
	IBOutlet UIButton *home;
	IBOutlet UIButton *backward;
	IBOutlet UIButton *forward;
	NSString *siteName;
	NSURL *currentUrl;
	

}

-(IBAction) goHome;
@property (retain) IBOutlet UIButton *home;
@property (retain) IBOutlet UIButton *backward;
@property (retain) IBOutlet UIButton *forward;
@property (retain) NSURL *currentURL;
@property (retain) IBOutlet UIWebView *webView;
@property (retain) NSString *url;
@property (retain) NSString *siteName;
@end
