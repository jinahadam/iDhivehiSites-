

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


@property (nonatomic, strong) NSNumber *messageId;
@property (nonatomic, strong) IBOutlet UITextField *name;
@property (nonatomic, strong) IBOutlet UITextField *url;


@end
