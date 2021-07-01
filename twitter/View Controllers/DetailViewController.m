//
//  DetailViewController.m
//  twitter
//
//  Created by Keng Fontem on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "TweetTableViewCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tweetMediaImageView;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (weak, nonatomic) IBOutlet UILabel *tweetContnetLabel;

@property (weak, nonatomic) IBOutlet UIButton *retweetedByButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mediaImageViewHeightAnchor;


@end
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViewFromTweet];
    
}

-(void)setUpViewFromTweet{
    // Initialization code
    self.tweetMediaImageView.layer.cornerRadius = 30;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2;
    
    Tweet* tweet = self.tweet;
    
    self.usernameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    self.nameLabel.text = tweet.user.name;
    
    self.profileImageView.image = nil;
    
        [self.profileImageView setImageWithURL: [tweet.user getUserURL]];
    
    self.dateLabel.text = tweet.createdAtString;
    self.tweetContnetLabel.text = tweet.text;
    
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
    
    self.mediaImageViewHeightAnchor.constant = self.tweetMediaImageView.frame.size.width * tweet.mediaAspectRatio;
}

@end
