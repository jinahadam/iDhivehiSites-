//
//  iDhivehiSitesAppDelegate.m
//  iDhivehiSites
//
//  Created by Jinah Adam on 7/24/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//


#import "iDhivehiSitesAppDelegate.h"

#import "iDhivehiSitesViewController.h"

@implementation iDhivehiSitesAppDelegate


@synthesize window;

@synthesize viewController;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	
	//[FlurryAPI startSession:@"6HZL2PU6FFV1IFGAXVWN"];

	
    // Override point for customization after application launch.
     
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

    // Save data if appropriate.
}

- (void)dealloc {
	[navigationController release];
    [window release];
    [viewController release];
    [super dealloc];
}

@end

