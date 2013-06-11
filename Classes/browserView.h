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
@property (strong) IBOutlet UIButton *home;
@property (strong) IBOutlet UIButton *backward;
@property (strong) IBOutlet UIButton *forward;
@property (strong) NSURL *currentURL;
@property (strong) IBOutlet UIWebView *webView;
@property (strong) NSString *url;
@property (strong) NSString *siteName;
@end
