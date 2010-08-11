//
//  TwitterAgent.h
//  Pagination
//
//  Created by Shaikh Sonny Aman on 1/6/10.
//  Copyright 2010 SHAIKH SONNY AMAN :) . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *	TwitterAgent is another helper class to help you out in posting twitter.
 *	
 *	It does not use Open Auth. User has to provide his/her username and password
 */

@interface TwitterAgent :UIViewController <UITextFieldDelegate, UITextViewDelegate,UIAlertViewDelegate>{
	/**
	 * Views  needed in the twitter alert box
	 */
	UITextView *txtMessage;
    UITextField *txtPassword;
    UITextField *txtUsername;
	
	UILabel* lblId;
	UILabel* lblPassword;
	UILabel* lblURL;
	UILabel* lblCharLeft;
	
	
	/**
	 * Holds user info and message
	 */
	NSString* userName;
	NSString* password;
	NSString* sharedLink;
	NSString* message;
	
	/**
	 * The login dialog
	 */
	UIAlertView* loginDialog;
	
	/** The messsage dialog
	 *
	 */
	UIAlertView* messageDialog;
	
	/**
	 * Flags needed for internal use
	 */
	int currentAlertTag;
	BOOL isLogged;
	BOOL isAuthFailed;
	BOOL loginOnly;
	
	id parentsv;
	
	int maxCharLength;
	
}

- (IBAction) OnCancel:(id)sender;
- (IBAction) OnSend:(id)sender;
- (void) login;
- (void) logout;
- (BOOL) isConnected;
- (void) OnLogin:(id)sender;

+ (TwitterAgent*) defaultAgent;
- (void) twit;
- (void) twit:(NSString*)text;
- (void) twit:(NSString*)text withLink:(NSString*)link makeTiny:(BOOL)yesOrno;

@property(nonatomic,assign) NSString* userName;
@property(nonatomic,assign) NSString* password;
@property(nonatomic,retain) NSString* sharedLink;
@property(nonatomic,retain) NSString* message;

@property(nonatomic,assign) id parentsv;

@property(nonatomic,assign) BOOL loginOnly;
@end
