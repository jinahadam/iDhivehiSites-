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
	NSString *documentsDirectory = paths[0];
	
	plistPath = [documentsDirectory stringByAppendingPathComponent:@"sites.plist"];
	dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath] ;
	
	
	tableData[0] = dict;
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
	
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = paths[0];
	
	plistPath = [documentsDirectory stringByAppendingPathComponent:@"sites.plist"];
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	
	if ( [fileManager fileExistsAtPath:plistPath] ) {
		
		dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath] ;
		
		
	} else {
		
		dict = [NSMutableDictionary dictionaryWithCapacity:1];
		
        
		pageURLs = [[NSArray alloc] initWithObjects:@"http://www.muraasil.com/start.html",@"http://semicolon.com.mv/haveeru",@"http://mdp.org.mv/",@"http://minivannews.com/dhivehi/",@"http://www.miadhu.com/dv/",@"http://www.haamadaily.com/",@"http://www.mnbc.com.mv/main/",nil];
		pageTitles = [[NSArray alloc] initWithObjects: @"މުރާސިލް",@"ހަވީރު",@"އެމް.ޑީ.ޕީ",@"މިނިވަން ނިއުސް ",@"މިއަދު",@"ހާމަ",@"އެމް.އެން.ބީ.ސީ",nil];
		pageIMGs = [[NSArray alloc] initWithObjects: @"muraasil.png",@"haveeru.png",@"mdp.png",@"minivan.png",@"miadhu.png",@"haama.png",@"mnbc_logo.png",nil];
		
		
		NSMutableArray *list = [NSMutableArray arrayWithCapacity:1];
		for (int i = 0; i < [pageURLs count]; i++) {
			NSDictionary *newsite = @{@"site": @[pageIMGs[i],pageURLs[i],pageTitles[i]]};
			[list addObject:newsite];

		}
		
		dict[@"dhivehisites"] = list;
		
		[dict writeToFile:plistPath atomically:YES];
		
		
		
		
	}
	
	tableData = [[NSMutableArray alloc] init];
	
	[tableData addObject:dict];

    
}



-(IBAction)addNew {
	
    NSLog(@"Add New");
	
	newSite *new = [[newSite alloc] initWithNibName:@"newSite" bundle:nil];
	
	NSNumber *mid = [[NSNumber alloc] init];
	
	
	mid = @1.5;
	
	new.messageId = mid;
	
	[self.navigationController pushViewController:new animated:YES];
	
	
	mid = nil;
	

	
	
}

- (NSString *) applicationDocumentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectoryPath = paths[0];
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
     return [tableData[0][@"dhivehisites"] count];
	//return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;	
	NSArray *data = tableData[0][@"dhivehisites"];
	NSDictionary *row = data[indexPath.row];
	NSArray *celldata = row[@"site"];
	
    
	[[NSBundle mainBundle] loadNibNamed:@"cell" owner:self options:NULL];
	cell = nibLoadedCell;
	UILabel *val = (UILabel*) [cell viewWithTag:1];
	val.font = [UIFont fontWithName:@"Mv Iyyu Normal" size:24];
	val.text = celldata[2]; 
	//val.textAlignment = UITextAlignmentRight;

	
	//UILabel *url = (UILabel*) [cell viewWithTag:3];
	//url.text = [celldata objectAtIndex:1]; 
	
	UIImageView *image = (UIImageView*) [cell viewWithTag:2];
	//val.text = [celldata objectAtIndex:2];  
	image.image = [UIImage imageNamed:celldata[0]];
	
	
    
	
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
		NSString *documentsDirectory = paths[0];
		plistPath = [documentsDirectory stringByAppendingPathComponent:@"sites.plist"];
		dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath] ;
		
		NSMutableArray *list = dict[@"dhivehisites"];
		
		[list removeObjectAtIndex:indexPath.row];		
		
		dict[@"dhivehisites"] = list;
		
		[dict writeToFile:plistPath atomically:YES];
		
		tableData[0] = dict;
		
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    
	NSArray *data = tableData[0][@"dhivehisites"];
	NSDictionary *row = data[indexPath.row];
	NSArray *celldata = row[@"site"];
    
	
	
			
		
		
		self.navigationItem.backBarButtonItem =
		[[UIBarButtonItem alloc] initWithTitle:@"Home"
										 style: UIBarButtonItemStyleBordered
										target:nil
										action:nil];
		
				
		NSString * url = celldata[1];
		//UIImage * img = [UIImage imageNamed: @"loading.png"];
		
		browserView *browser = [[browserView alloc] initWithNibName:@"browserView" bundle:nil];
		
		browser.url = url;
		browser.siteName =  celldata[2];
		
		
		
		[self.navigationController pushViewController:browser animated:YES];
		
		
		
	
	
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





@end
