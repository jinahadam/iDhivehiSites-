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

	
	[Mobclix startWithApplicationId:@"D82BBEF8-21B3-4544-A493-7D8DCD9BC607"];
	
	
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

