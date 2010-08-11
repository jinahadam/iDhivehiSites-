

#import <UIKit/UIKit.h>


@interface newSite : UIViewController {
      NSNumber *messageId;
	  IBOutlet UITextField *name;
	  IBOutlet UITextField *url;
	//IBOutlet UILabel *counter;
}


-(IBAction) saveOnly;
-(IBAction) saveAndGo;
-(IBAction) goBack;


@property (nonatomic, retain) NSNumber *messageId;
@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *url;


@end
