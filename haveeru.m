//
//  haveeru.m
//  iDhivehiSites
//
//  Created by Jinah Adam on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "NSString+HTML.h"
#import "MWFeedParser.h"
#import "haveeru.h"
#import "haveeruArticle.h"

@implementation haveeru
@synthesize itemsToDisplay,nibLoadedCell;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	// Super
	[super viewDidLoad];
	
	// Setup
	self.title = @"Haveeru";
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	parsedItems = [[NSMutableArray alloc] init];
	self.itemsToDisplay = [NSArray array];
	
	// Refresh button
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
																							target:self 
																							action:@selector(refresh)] autorelease];
	
	// Create parser
	feedParser = [[MWFeedParser alloc] initWithFeedURL:@"http://www.haveeru.com.mv/rss/?category=local&lang=dhivehi&limit=10"];
	feedParser.delegate = self;
	feedParser.feedParseType = ParseTypeItemsOnly; // Parse feed info and all items
	feedParser.connectionType = ConnectionTypeAsynchronously;
	[feedParser parse];
	
}

#pragma mark -
#pragma mark Parsing

// Reset and reparse
- (void)refresh {
	if (![feedParser isParsing]) {
		self.title = @"Refreshing...";
		[parsedItems removeAllObjects];
		[feedParser parse];
		self.tableView.userInteractionEnabled = NO;
		self.tableView.alpha = 0.3;
	}
}

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
	//NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
	//NSLog(@"Parsed Feed Info: “%@”", info.title);
	self.title = info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
	//NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
	//NSLog(@"Finished Parsing");
	self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
						   [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"date" 
																				 ascending:NO] autorelease]]];
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
	self.title = @"Headlines";
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"Finished Parsing With Error: %@", error);
	self.title = @"Failed";
	self.itemsToDisplay = [NSArray array];
	[parsedItems removeAllObjects];
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemsToDisplay.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"haveeruCell" owner:self options:NULL];
		cell = nibLoadedCell;
    }
    
	
    
	// Configure the cell.
	MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
	if (item) {
		
		// Process
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
		
		// Set
		
		UILabel *lblTitle = (UILabel*) [cell viewWithTag:1];
		
		lblTitle.font = [UIFont fontWithName:@"Mv Iyyu Normal" size:20];
		
		lblTitle.text = [itemTitle stringByTrimmingCharactersInSet:
							   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
		lblTitle.textAlignment = UITextAlignmentRight;
		lblTitle.lineBreakMode = UILineBreakModeWordWrap;
		lblTitle.numberOfLines = 2; // 2 lines ; 0 - dynamical number of lines
		
		
		UILabel *lblDate = (UILabel*) [cell viewWithTag:2];
		
		NSMutableString *subtitle = [NSMutableString string];
		if (item.date) [subtitle appendFormat:@"%@", [formatter stringFromDate:item.date]];
		//[subtitle appendString:item.date];
		lblDate.text = subtitle;
		//lblDate.font = [UIFont fontWithName:@"Arial" size:10];
		
	}
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	MWFeedItem *item = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
	
	
	
	NSString * url = [NSString stringWithFormat:@"http://jinahadam.com/haveeru.php?query=%@", item.link];
	haveeruArticle *browser = [[haveeruArticle alloc] init];
	browser.aUrl = url;
	
	
	
	[self.navigationController pushViewController:browser animated:YES];
	
	[browser release];

	
	
	[item release];
	/*
	 // Show detail
	 DetailTableViewController *detail = [[DetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	 detail.item = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
	 [self.navigationController pushViewController:detail animated:YES];
	 [detail release];
	 
	 // Deselect
	 [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	 */
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[formatter release];
	[parsedItems release];
	//[itemsToDisplay release];
	[feedParser release];
    [super dealloc];
}

@end
