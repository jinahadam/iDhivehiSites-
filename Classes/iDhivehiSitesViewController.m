//
//  iDhivehiSitesViewController.m
//  iDhivehiSites
//
//  Created by Jinah Adam on 7/24/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//
@interface UIImage (TPAdditions)
- (UIImage*)imageScaledToSize:(CGSize)size;
@end

@implementation UIImage (TPAdditions)
- (UIImage*)imageScaledToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end





#import "iDhivehiSitesViewController.h"
#import "newSite.h"
#import "browserView.h"

@implementation iDhivehiSitesViewController


@synthesize nibLoadedCell;
@synthesize table;



#pragma mark -
#pragma mark View lifecycle

-(void) viewWillAppear:(BOOL)animated {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	plistPath = [documentsDirectory stringByAppendingPathComponent:@"sites.plist"];
	dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath] ;
	
	
	[tableData replaceObjectAtIndex:0 withObject:dict];
	[table reloadData];
     
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normalbg.png"]];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	self.title = @"iDhivehiSites";	
	
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addNew)];   
	self.navigationItem.rightBarButtonItem = anotherButton;
	[anotherButton release];
	
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	plistPath = [documentsDirectory stringByAppendingPathComponent:@"sites.plist"];
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	
	if ( [fileManager fileExistsAtPath:plistPath] ) {
		
		dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath] ;
		
		
	} else {
		
		dict = [NSMutableDictionary dictionaryWithCapacity:1];
		
        
		pageURLs = [[NSArray alloc] initWithObjects:@"http://www.muraasil.com/start.html",@"http://www.haveeru.com.mv",@"http://mdp.org.mv/",@"http://minivannews.com/dhivehi/",@"http://www.miadhu.com/dv/",@"http://www.haamadaily.com/",@"http://jazeera.com.mv/",nil];
		pageTitles = [[NSArray alloc] initWithObjects: @"Muraasil",@"Haveeru",@"MDP",@"Minivan News",@"Miadhu News",@"Haama Daily",@"Jazeera",nil];
		pageIMGs = [[NSArray alloc] initWithObjects: @"muraasil.png",@"haveeru.png",@"mdp.png",@"minivan.png",@"miadhu.png",@"haama.png",@"jazeera.png",nil];
		
		
		NSMutableArray *list = [NSMutableArray arrayWithCapacity:1];
		for (int i = 0; i < [pageURLs count]; i++) {
			NSDictionary *newsite = [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:[pageIMGs objectAtIndex:i],[pageURLs objectAtIndex:i],[pageTitles objectAtIndex:i],nil] forKey:@"site"];
			[list addObject:newsite];
		}
		
		[dict setObject:list forKey:@"dhivehisites"];
		
		[dict writeToFile:plistPath atomically:YES];
		
		
		
		
	}
	
	tableData = [[NSMutableArray alloc] init];
	
	[tableData addObject:dict];

    
}



-(IBAction)addNew {
	
    NSLog(@"Add New");
	
	newSite *new = [[newSite alloc] initWithNibName:@"newSite" bundle:nil];
	
	NSNumber *mid = [[NSNumber alloc] init];
	
	
	mid = [NSNumber numberWithDouble:1.5];
	
	new.messageId = mid;
	
	[self.navigationController pushViewController:new animated:YES];
	
	[new release];
	
	mid = nil;
	
	[mid release];

	
	
}

- (NSString *) applicationDocumentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	return documentsDirectoryPath;
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return YES;
}



#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//NSLog(@"%i",[[[tableData objectAtIndex:0] objectForKey:@"dhivehisites"] count]);
     return [[[tableData objectAtIndex:0] objectForKey:@"dhivehisites"] count];
	//return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;	
	NSArray *data = [[tableData objectAtIndex:0] objectForKey:@"dhivehisites"];
	NSDictionary *row = [data objectAtIndex:indexPath.row];
	NSArray *celldata = [row objectForKey:@"site"];
	
    
	[[NSBundle mainBundle] loadNibNamed:@"cell" owner:self options:NULL];
	cell = nibLoadedCell;
	UILabel *val = (UILabel*) [cell viewWithTag:1];
	val.text = [celldata objectAtIndex:2]; 
	
	//UILabel *url = (UILabel*) [cell viewWithTag:3];
	//url.text = [celldata objectAtIndex:1]; 
	
	UIImageView *image = (UIImageView*) [cell viewWithTag:2];
	//val.text = [celldata objectAtIndex:2];  
	image.image = [UIImage imageNamed:[celldata objectAtIndex:0]];
	
    
	
	//cell.textLabel.text = [celldata objectAtIndex:2];
	
	//UIImage *image = [UIImage imageNamed:[celldata objectAtIndex:0]];
	//if ( image ) {
	//	cell.image = [image imageScaledToSize:CGSizeMake(38, 38)];
	//}
    return cell; 
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
	if (indexPath.row > 6) {
		return YES;
	}
    return NO;
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		plistPath = [documentsDirectory stringByAppendingPathComponent:@"sites.plist"];
		dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath] ;
		
		NSMutableArray *list = [dict objectForKey:@"dhivehisites"];
		
		[list removeObjectAtIndex:indexPath.row];		
		
		[dict setObject:list forKey:@"dhivehisites"];
		
		[dict writeToFile:plistPath atomically:YES];
		
		[tableData replaceObjectAtIndex:0 withObject:dict];
		
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}



/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSArray *data = [[tableData objectAtIndex:0] objectForKey:@"dhivehisites"];
	NSDictionary *row = [data objectAtIndex:indexPath.row];
	NSArray *celldata = [row objectForKey:@"site"];
    
	self.navigationItem.backBarButtonItem =
	[[UIBarButtonItem alloc] initWithTitle:@"Home"
									 style: UIBarButtonItemStyleBordered
									target:nil
									action:nil];
	
	
	NSString * url = [celldata objectAtIndex:1];
	//UIImage * img = [UIImage imageNamed: @"loading.png"];
	
	browserView *browser = [[browserView alloc] initWithNibName:@"browserView" bundle:nil];
	
	browser.url = url;
	browser.siteName =  [celldata objectAtIndex:2];

	
	[self.navigationController pushViewController:browser animated:YES];
	
	[browser release];
	
	
    
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}



@end
