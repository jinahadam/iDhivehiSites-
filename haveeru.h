//
//  haveeru.h
//  iDhivehiSites
//
//  Created by Jinah Adam on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MWFeedParser.h"

@interface haveeru : UITableViewController <MWFeedParserDelegate> {
	
	// Parsing
	MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
	
	// Displaying
	NSArray *itemsToDisplay;
	NSDateFormatter *formatter;
		UITableViewCell *nibLoadedCell;
}

// Properties
@property (nonatomic, retain) UITableViewCell *nibLoadedCell;
@property (nonatomic, retain) NSArray *itemsToDisplay;

@end