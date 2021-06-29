//
//  ComposeViewController.m
//  twitter
//
//  Created by Keng Fontem on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.closeButton.target = self;
    self.closeButton.action = @selector(closeButtonPressed);
    
    self.tweetButton.target = self;
    self.tweetButton.action = @selector(tweetButtonPressed);
}

-(void)tweetButtonPressed{
    [[APIManager shared]postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
-(void)closeButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
