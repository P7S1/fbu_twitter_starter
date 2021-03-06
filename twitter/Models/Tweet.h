//
//  Tweet.h
//  twitter
//
//  Created by Keng Fontem on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject
// MARK: Properties
@property (nonatomic, strong) NSString *idStr; // For favoriting, retweeting & replying
@property (nonatomic, strong) NSString *text; // Text content of tweet
@property (nonatomic) int favoriteCount; // Update favorite count label
@property (nonatomic) BOOL favorited; // Configure favorite button
@property (nonatomic) int retweetCount; // Update favorite count label
@property (nonatomic) BOOL retweeted; // Configure retweet button
@property (nonatomic, strong) User *user; // Contains Tweet author's name, screenname, etc.
@property (nonatomic, strong) NSString *createdAtString; // Display date
@property (nonatomic) int replyCount;
@property (nonatomic, strong) NSURL* _Nullable tweetMediaURL;
@property (nonatomic) CGFloat mediaAspectRatio;
// For Retweets
@property (nonatomic, strong) User *retweetedByUser;  // user who retweeted if tweet is retweet

// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

//Tweets with array
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

- (NSURL*)getUserURL;

@end

NS_ASSUME_NONNULL_END
