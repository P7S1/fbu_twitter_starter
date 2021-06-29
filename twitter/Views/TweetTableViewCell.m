//
//  TweetTableViewCell.m
//  twitter
//
//  Created by Keng Fontem on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "APIManager.h"
@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)retweetButtonPressed:(id)sender {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
}
- (IBAction)likeButtonPressed:(id)sender {
    NSLog(@"Like button pressed");
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
