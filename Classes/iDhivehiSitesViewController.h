//
//  iDhivehiSitesViewController.h
//  iDhivehiSites
//
//  Created by Jinah Adam on 7/24/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iDhivehiSitesViewController : UIViewController  <UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UITableViewCell *nibLoadedCell;
	IBOutlet UITableView *table;
	NSMutableArray *tableData;
	NSMutableDictionary *dict;
	NSString *plistPath;
	NSArray  * pageTitles;
	NSArray  * pageURLs;
	NSArray  * pageIMGs;
}
-(IBAction)addNew;
- (NSString *) applicationDocumentsDirectory;
@property (nonatomic, strong) IBOutlet UITableViewCell *nibLoadedCell;
@property (nonatomic, strong) IBOutlet UITableView *table;

@end

