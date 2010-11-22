//
//  MobclixAds.h
//  Mobclix iOS SDK
//
//  Copyright 2010 Mobclix. All rights reserved.
//

typedef enum {
	MCFeedbackRatingUnknown = 0,
	MCFeedbackRatingPoor,
	MCFeedbackRatingFair,
	MCFeedbackRatingGood,
	MCFeedbackRatingVeryGood,
	MCFeedbackRatingExcellent
} MCFeedbackRating;

typedef struct {
	MCFeedbackRating categoryA;
	MCFeedbackRating categoryB;
	MCFeedbackRating categoryC;
	MCFeedbackRating categoryD;
	MCFeedbackRating categoryE;
} MCFeedbackRatings;

@interface MobclixFeedback : NSObject {}

// Send back qualitative feedback
+ (void)sendComment:(NSString*)comment;

// Send back quantitative feedback
+ (void)sendRatings:(MCFeedbackRatings)ratings;
 
@end
