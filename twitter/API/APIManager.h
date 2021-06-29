//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"
typedef enum {
    unlike,
    like,
    retweet
} TweetActionEndpoint;

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;
- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;
- (void)callActionOnTweet:(Tweet *)tweet actionEndPoint:(TweetActionEndpoint)action completion:(void (^)(Tweet *, NSError *))completion;
- (NSString*)getTweetActionEndPoint: (TweetActionEndpoint)action;
@end
