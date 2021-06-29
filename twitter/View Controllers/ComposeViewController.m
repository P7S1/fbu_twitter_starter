//
//  ComposeViewController.m
//  twitter
//
//  Created by Keng Fontem on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.closeButton.action = @selector(closeButtonPressed);
    self.tweetButton.action = @selector(tweetButtonPressed);
}

-(void)tweetButtonPressed{
    
}
-(void)closeButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
