//
//  Tweet.m
//  twitter
//
//  Created by Keng Fontem on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "DateTools.h"
@implementation Tweet
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {

        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        self.replyCount = [dictionary[@"reply_count"] intValue];
        
        
        // initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        NSString* mediaURLString = dictionary[@"entities"][@"media"][0][@"media_url_https"];
        
        if (mediaURLString != nil){
            self.tweetMediaURL = [[NSURL alloc]initWithString:mediaURLString];
            double width = [dictionary[@"entities"][@"media"][0][@"sizes"][@"large"][@"w"] longValue];
            double height = [dictionary[@"entities"][@"media"][0][@"sizes"][@"large"][@"h"] longValue];
            
            self.mediaAspectRatio = height/width;
        }else{
            self.mediaAspectRatio = 1;
        }
        if (self.mediaAspectRatio < 0.5){ self.mediaAspectRatio = 0.5; }
        if (self.mediaAspectRatio > 1.5) { self.mediaAspectRatio = 1.5; }
        
        
        // Format createdAt date string
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        
        self.createdAtString = date.shortTimeAgoSinceNow;
        
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    
    
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}


- (NSURL *)getUserURL{
    NSString *URLString = self.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    return url;
}
@end
