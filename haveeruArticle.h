//
//  haveeruArticle.h
//  iDhivehiSites
//
//  Created by Jinah Adam on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface haveeruArticle : UIViewController {
	IBOutlet UIWebView *aText;
	NSString *aUrl;
}

@property (nonatomic, retain)  IBOutlet UIWebView *aText;
@property (nonatomic, retain)  IBOutlet NSString *aUrl;

@end
