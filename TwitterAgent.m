//
//  TwitterAgent.m
//  Pagination
//
//  Created by Shaikh Sonny Aman on 1/6/10.
//  Copyright 2010 SHAIKH SONNY AMAN :) . All rights reserved.
//

#import "TwitterAgent.h"
#import "BusyAgent.h"

#define XAGENTS_TWITTER_CONFIG_FILE @"xagents_twitter_conifg_file.plist"

static TwitterAgent* agent;

@implementation TwitterAgent

@synthesize userName,password,sharedLink,parentsv,loginOnly, message;
-(id)init{
	self = [super init];
	maxCharLength = 140;
	parentsv = nil;
	
	isLogged = NO;
	txtMessage = [[UITextView alloc] initWithFrame:CGRectMake(15, 80, 250, 60)];
	UIImageView* bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fb_message_bg.png"]];
	bg.frame = txtMessage.frame;
	
	lblCharLeft = [[UILabel alloc] initWithFrame:CGRectMake(15, 142, 250, 20)];
	lblCharLeft.font = [UIFont systemFontOfSize:10.0f];
	lblCharLeft.textAlignment = UITextAlignmentRight;
	lblCharLeft.textColor = [UIColor whiteColor];
	lblCharLeft.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
	
	txtUsername = [[UITextField alloc]initWithFrame:CGRectMake(110, 60, 150, 30)];
	txtPassword = [[UITextField alloc]initWithFrame:CGRectMake(110, 95, 150, 30)];
	txtPassword.secureTextEntry = YES;
	
	lblId = [[UILabel alloc]initWithFrame:CGRectMake(5, 60, 100, 30)];
	lblPassword = [[UILabel alloc]initWithFrame:CGRectMake(5, 95, 100, 30)];
	lblId.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
	lblPassword.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
	lblId.textColor = [UIColor whiteColor];
	lblPassword.textColor = [UIColor whiteColor];
	
	txtMessage.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
	
	lblId.text = @"Username:";
	lblPassword.text =@"Password:";
	lblId.textAlignment = UITextAlignmentRight;
	lblPassword.textAlignment = UITextAlignmentRight;
	
	
	txtUsername.borderStyle = UITextBorderStyleRoundedRect;
	txtPassword.borderStyle = UITextBorderStyleRoundedRect;
	
	txtMessage.delegate = self;
	txtUsername.delegate = self;
	txtPassword.delegate = self;
	
	loginDialog = [[UIAlertView alloc] initWithTitle:@"Login to twitter" message:@"\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Log in",nil];
	
	loginDialog.tag =1;
	
	[loginDialog addSubview:txtUsername];
	[loginDialog addSubview:txtPassword];
	[loginDialog addSubview:lblId];
	[loginDialog addSubview:lblPassword];
	UIImageView* logo = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 48, 48)];
	logo.image = [UIImage imageNamed:@"Twitter_logo.png"];
	[loginDialog addSubview:logo];

	[logo release];
	
	
	lblURL  = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 250, 20)];
	lblURL.font = [UIFont systemFontOfSize:12];
	lblURL.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0]; 
	lblURL.textColor = [UIColor whiteColor];
	
	messageDialog = [[UIAlertView alloc] initWithTitle:sharedLink message:@"\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send",nil];
	messageDialog.tag =2;
	[messageDialog addSubview:lblCharLeft];
	[messageDialog	addSubview:bg];
	[messageDialog addSubview:txtMessage];
	[messageDialog addSubview:lblURL];
	[messageDialog bringSubviewToFront:txtMessage];
	[bg release];
	
	
	
	UIImageView* logo1 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 42, 42)];
	logo1.image = [UIImage imageNamed:@"twitter-logo-twit.png"];
	[messageDialog addSubview:logo1];
	[logo1 release];
	
	return self;
}
-(void)logout{
	txtUsername.text =@"";
	txtPassword.text =@"";
	isLogged = NO;
}

-(BOOL)isConnected{
	return isLogged;
}
-(void)login{
	
	if(message){
		txtMessage.text = message;
	}
	isAuthFailed = NO;
	
	maxCharLength = 139 - ([sharedLink length] + [message length]);
	messageDialog.title = @"Tweet this post";
	lblCharLeft.text = [NSString stringWithFormat:@"%d",maxCharLength];
	lblURL.text = sharedLink;
	
	
	if(isLogged){
		[messageDialog show];
	}else{
		[loginDialog show];
	}
}

- (void)willPresentAlertView:(UIAlertView *)alertView{
	currentAlertTag = alertView.tag;
	//loginDialog.transform = CGAffineTransformTranslate(loginDialog.transform, 10, -100);
	if(currentAlertTag==1){
		NSDictionary* config = [NSDictionary dictionaryWithContentsOfFile:XAGENTS_TWITTER_CONFIG_FILE];
		if(config){
			NSString* uname = [config valueForKey:@"username"];
			if(uname){
				txtUsername.text = uname;
			}
			
			NSString* pw = [config valueForKey:@"password"];
			if(pw){
				txtPassword.text = pw;
			}
		}
		
		alertView.frame = CGRectMake(alertView.frame.origin.x,50,alertView.frame.size.width, alertView.frame.size.height);
	}else{
		alertView.frame = CGRectMake(alertView.frame.origin.x,30,alertView.frame.size.width, alertView.frame.size.height);
	}
}
- (void)didPresentAlertView:(UIAlertView *)alertView{
	
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	if(buttonIndex ==alertView.cancelButtonIndex){
		[[BusyAgent defaultAgent] makeBusy:NO];
		return;
	}
	
	if(currentAlertTag==1){
		if([[alertView buttonTitleAtIndex:buttonIndex] compare:@"Log in"] == NSOrderedSame){
			if([txtUsername.text length] >0 && [txtPassword.text length] > 0){
	//			SET_BUSY_MODE
				
				[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(OnLogin:) userInfo:nil repeats:NO];
			}else {
	//			UNSET_BUSY_MODE
				[[BusyAgent defaultAgent] makeBusy:NO];
			}

		}else {
	//		UNSET_BUSY_MODE
			[[BusyAgent defaultAgent] makeBusy:NO];
		}

	}else{
		if([[alertView buttonTitleAtIndex:buttonIndex] compare:@"Send"] == NSOrderedSame){
	//		SET_BUSY_MODE
			//[[BusyAgent defaultAgent] makeBusy:YES];
			// used timer to avoid random crashes
			[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(OnSend:) userInfo:nil repeats:NO];
		}
	}
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
	const char* str = [text UTF8String];
	
	int s = str[0];
	if(s!=0)
	if((range.location + range.length) > maxCharLength){
		return NO;
	}else{
		int left = 139 - ([sharedLink length] + [textView.text length]);
		lblCharLeft.text= [NSString stringWithFormat:@"%d",left];
		return YES;
	}
	
	int left = 139 - ([sharedLink length] + [textView.text length]);
	lblCharLeft.text= [NSString stringWithFormat:@"%d",left];
	return YES;
}
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

//}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
	
	
	[textField becomeFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
	//loginDialog.message = @"\n\n\n";
	if(currentAlertTag==1){
		//loginDialog.center = currentAlertCenter;
	}else{
		//messageDialog.center = currentAlertCenter;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	//[self startUpload];
	return NO;
}
-(void)viewWillAppear:(BOOL)animated{
	//txtMessage.text = @"Check out this SUPER cute puppy!";
	NSString* msg = @"Check this out!";
	//NSString* msg = [[PhotosUtil localConfig] getTwitterMessage];
	txtMessage.text =msg;
	txtUsername.text = userName;
	txtPassword.text = password;
	
	//btnSend.enabled = YES;
	//btnCancel.enabled = YES;
}


- (IBAction)OnCancel:(id)sender {
	//UNSET_BUSY_MODE
	
	[[BusyAgent defaultAgent] makeBusy:NO];
    //[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)OnLogin:(id)sender {
	

	NSString*  postURL = @"http://twitter.com/statuses/update.xml";
	NSString *myRequestString = [NSString stringWithFormat:@""];
	
	
	NSData *myRequestData = [ NSData dataWithBytes: [ myRequestString UTF8String ] length: [ myRequestString length ] ];
	NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString:postURL ] ]; 
	[ request setHTTPMethod: @"POST" ];
	[ request setHTTPBody: myRequestData ];
	
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (!theConnection) {
		UIAlertView* aler = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Failed to Connect to twitter" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
		[aler show];
		[aler release];
	} 	
	[request release];

	
}

- (IBAction)OnSend:(id)sender {
	[[BusyAgent defaultAgent] makeBusy:YES];
    //btnSend.enabled = NO;
	//btnCancel.enabled = NO;
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"notifyImageDetailWait" object:nil userInfo:nil];
	
	NSString*  postURL = @"http://twitter.com/statuses/update.xml";
	NSString *myRequestString;
	if(sharedLink){
		myRequestString = [NSString stringWithFormat:@"&status=%@",[NSString stringWithFormat:@"%@\n%@",txtMessage.text,sharedLink]];
	}else{
		myRequestString = [NSString stringWithFormat:@"&status=%@",[NSString stringWithFormat:@"%@",txtMessage.text]];
	}
	
	
	
	NSData *myRequestData = [ NSData dataWithBytes: [ myRequestString UTF8String ] length: [ myRequestString length ] ];
	NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString:postURL ] ]; 
	[ request setHTTPMethod: @"POST" ];
	[ request setHTTPBody: myRequestData ];
	
	//connection = [NSURLConnection connectionWithRequest:request delegate:self];
	//NSURLResponse* res;
	//NSError* er;
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (!theConnection) {
		UIAlertView* aler = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Failed to Connect to twitter" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
		[aler show];
		[aler release];
		//UNSET_BUSY_MODE
		//[[NSNotificationCenter defaultCenter] postNotificationName:@"notifyImageDetailWaitHide" object:nil userInfo:nil];
	} 	
	[request release];
	//[theConnection release];
	
}
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
	if(isAuthFailed){
		UIAlertView* aler = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Invalid ID/Password" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
		[aler show];
		[aler release];
	}else{
		UIAlertView* aler = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Failed to connect to Twitter" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
		[aler show];
		[aler release];
	
	}
	
	//UNSET_BUSY_MODE
	[[BusyAgent defaultAgent] makeBusy:NO];
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"notifyImageDetailWaitHide" object:nil userInfo:nil];
	
	isAuthFailed = NO;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	isAuthFailed = NO;
	isLogged = YES;
	//UNSET_BUSY_MODE
	[[BusyAgent defaultAgent] makeBusy:NO];
    // do something with the data
    // receivedData is declared as a method instance elsewhere
   // ////////nslog(@"Succeeded! Received %d bytes of data",[receivedData length]);
	
    // release the connection, and the data object
    [connection release];
	if(currentAlertTag == 2){
		UIAlertView* aler = [[UIAlertView alloc] initWithTitle:@"Twitter" message:@"Tweet Posted!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
		[aler show];
		[aler release];
		[[BusyAgent defaultAgent] makeBusy:NO];
		//[[NSNotificationCenter defaultCenter] postNotificationName:@"notifyImageDetailWaitHide" object:nil userInfo:nil];
		//[self.parentViewController dismissModalViewControllerAnimated:YES];
	}else{
		//if(!loginOnly){
			
			[messageDialog show];
			
		//}else {
		//	loginOnly = NO;
		//}
		[[NSNotificationCenter defaultCenter] postNotificationName:@"notifyTwitterLoggedIn" object:nil userInfo:nil];
		//[[NSNotificationCenter defaultCenter] postNotificationName:@"notifyImageDetailWaitHide" object:nil userInfo:nil];

	}
	
	
    
}
-(void)connection:(NSURLConnection *)connection 
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	NSDictionary* config = [NSDictionary dictionaryWithObjectsAndKeys:txtUsername.text,@"username",txtPassword.text,@"password",nil];
	[config writeToFile:XAGENTS_TWITTER_CONFIG_FILE atomically:YES];
    if ([challenge previousFailureCount] == 0) {
		
        NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:txtUsername.text
                                                 password:txtPassword.text
                                              persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
    } else {
		isAuthFailed = YES;
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

+ (TwitterAgent*)defaultAgent{
	if(!agent){
		agent = [TwitterAgent new];
	}
	return agent;
}

- (void) twit{
	[self twit:nil withLink:nil makeTiny:NO];
}
- (void) twit:(NSString*)text{
	[self twit:text withLink:nil makeTiny:NO];
}


- (void) twit:(NSString*)text withLink:(NSString*)link makeTiny:(BOOL)yesOrno{
	[[BusyAgent defaultAgent] makeBusy:YES];
	if(link){
		if(yesOrno){
			link = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
			NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=@",link]];
			link = [NSString stringWithContentsOfURL:url];
		}
	}
	self.message = text;
	self.sharedLink = link;
	[self login];
	
}
-(void)dealloc{
	[message release];
	[txtMessage release];
	[txtUsername release];
	[txtPassword release];
	
	[lblId release];
	[lblPassword release];
	[lblURL release];
	
	
	[loginDialog release];
	[messageDialog release];
	//[btnSend release];
	//[btnCancel release];
	[super dealloc];
}
@end
