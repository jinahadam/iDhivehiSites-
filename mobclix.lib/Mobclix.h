//
//  Mobclix.h
//  Mobclix iOS SDK
//
//  Copyright 2010 Mobclix. All rights reserved.
//

typedef enum {
	LOG_LEVEL_DEBUG =	1 << 0,
	LOG_LEVEL_INFO	=	1 << 1,
	LOG_LEVEL_WARN	=	1 << 2,
	LOG_LEVEL_ERROR	=	1 << 3,
	LOG_LEVEL_FATAL =	1 << 4
} MobclixLogLevel;

@class CLLocation;
@interface Mobclix : NSObject {
	
}

/**
 * Start up Mobclix using the applicationId provided in your application's Info.plist
 * This should be called in your AppDelegate's applicationDidFinishLaunching: method.
 */
+ (void)start;

/**
 * Start up Mobclix with a different applicationId
 * This should be called in your AppDelegate's applicationDidFinishLaunching: method.
 */
+ (void)startWithApplicationId:(NSString*)applicationId;

#pragma mark -
#pragma mark Logging

/**
 * Log a custom event
 */
+ (void)logEventWithLevel:(MobclixLogLevel)logLevel
			  processName:(NSString*)processName
				eventName:(NSString*)eventName
			  description:(NSString*)description
					 stop:(BOOL)stopProcess;

/**
 * Sync's the even logs.
 */
+ (void)sync;

#pragma mark -
#pragma mark Location
/**
 * Location information should only be sent to Mobclix if your application uses locations services.
 * If your application does not make use of location services, and you track the users location
 * your application will be rejected by Apple.
 */

/**
 * Update location
 */
+ (void)updateLocation:(CLLocation*)location;

#pragma mark -
#pragma mark Crash Reports
/**
 * The following methods will only work if you bundle PLCrashReporter with your app ( http://code.google.com/p/plcrashreporter/ )
 * To handle crash reporting automatically without prompting user
 * Add a key to your apps Info.plist called "MCAutoReportCrashes" and set it to true.
 */

/**
 * Checks if there are any crash report(s) to send, if so, send them to Mobclix
 * Use if you wish to send crash report(s) without prompting the user
 * This will be called automatically if MCAutoReportCrashes is true.
 */
+ (void)handleCrashReportIfPending;

/**
 * Checks to see if there are any check reports available.
 * This should be used with handleCrashReport to prompt the user before sending
 */
+ (BOOL)crashReportPending;

/*
 * Send available crash report(s) to Mobclix.
 * Should be called if you want to prompt the user before sending the crash report.
 */
+ (void)handleCrashReport;

/**
 * Clears out pending crash reports.
 * Only needs to be called if the user is prompted and doesn't want to send the crash report.
 */
+ (void)clearCrashReports;

#pragma mark -
#pragma mark Piracy Detection

/**
 * Checks to see if the current running app is cracked.
 * Use with discretion.  As with any piracy detection system, there is a risk of
 * legitimate users being detected as pirated.
 */
+ (BOOL)isApplicationCracked;

@end

