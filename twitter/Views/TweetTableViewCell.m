//
//  TweetTableViewCell.m
//  twitter
//
//  Created by Keng Fontem on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "APIManager.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tweetMediaImageView.layer.cornerRadius = 30;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2;
}

-(void)setUpFromTweet: (Tweet*) tweet{
    self.tweet = tweet;
    
    self.usernameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    self.nameLabel.text = tweet.user.name;
    
    self.profileImageView.image = nil;
    
        [self.profileImageView setImageWithURL: [tweet.user getUserURL]];
    
    self.dateLabel.text = tweet.createdAtString;
    self.tweetContentLabel.text = tweet.text;
    
    [self.replyButton setTitle:[NSString stringWithFormat:@"%i", tweet.replyCount] forState:UIControlStateNormal];
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", tweet.retweetCount] forState:UIControlStateNormal];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", tweet.favoriteCount] forState:UIControlStateNormal];
    
    if (tweet.favorited){
        UIImage* image = [UIImage imageNamed: @"favor-icon-red"];
        [self.likeButton setImage:image forState:UIControlStateNormal];
    }else{
        UIImage* image = [UIImage imageNamed: @"favor-icon"];
        [self.likeButton setImage:image forState:UIControlStateNormal];
    }
    
    if (tweet.retweetedByUser != nil){
        [self.retweetedByButton setHidden:NO];
        [self.retweetedByButton setTitle:[@"Retweeted by @" stringByAppendingString:tweet.retweetedByUser.name] forState:UIControlStateNormal];
    }else{
        [self.retweetedByButton setHidden:YES];
    }
    
    if (tweet.retweeted){
        UIImage* image = [UIImage imageNamed:@"retweet-icon-green"];
        [self.retweetButton setImage:image forState:UIControlStateNormal];
    }else{
        UIImage* image = [UIImage imageNamed:@"retweet-icon"];
        [self.retweetButton setImage:image forState:UIControlStateNormal];
    }
    
    if (tweet.tweetMediaURL != nil){
        [self.tweetMediaImageView setHidden:NO];
        [self.tweetMediaImageView setImageWithURL:tweet.tweetMediaURL];
    }else{
        [self.tweetMediaImageView setHidden:YES];
        self.tweetMediaImageView.image = nil;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)retweetButtonPressed:(id)sender {
    TweetActionEndpoint action;
    if (self.tweet.retweeted){
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        action = unretweet;
        UIImage* image = [UIImage imageNamed:@"retweet-icon"];
        [ self.retweetButton setImage:image forState:UIControlStateNormal];
        
    }else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        action = retweet;
        UIImage* image = [UIImage imageNamed:@"retweet-icon-green"];
        [ self.retweetButton setImage:image forState:UIControlStateNormal];
    }
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
    
    [[APIManager shared] callActionOnTweet:self.tweet actionEndPoint:action completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
    
}
- (IBAction)likeButtonPressed:(id)sender {
    TweetActionEndpoint action;
    if (self.tweet.favorited){
        self.tweet.favorited = false;
        self.tweet.favoriteCount -= 1;
        action = unlike;
        UIImage* image = [UIImage imageNamed:@"favor-icon"];
        [ self.likeButton setImage:image forState:UIControlStateNormal];
    }else{
        self.tweet.favorited = true;
        self.tweet.favoriteCount += 1;
        action = like;
        UIImage* image = [UIImage imageNamed:@"favor-icon-red"];
        [ self.likeButton setImage:image forState:UIControlStateNormal];
    }
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
    
    [[APIManager shared] callActionOnTweet:self.tweet actionEndPoint:action completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
    
}



@end
