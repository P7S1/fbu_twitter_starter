//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"
#import "ComposeViewController.h"
#import "DetailViewController.h"
#import <STPopup/STPopup.h>
@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<Tweet *>* tweets;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (strong, nonatomic) UIRefreshControl* refreshControl;
@property (weak, nonatomic) IBOutlet UIView *backgroundWhiteView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createANewTweetButton;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTweets];
    [self setUpTableView];
    [self setUpRefreshControl];
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    self.logoutButton.target = self;
    self.logoutButton.action = @selector(logoutButtonPressed);
    
    self.createANewTweetButton.target = self;
    self.createANewTweetButton.action = @selector(newTweetButtonPressed);
    
    self.
    self.backgroundWhiteView.clipsToBounds = YES;
    self.backgroundWhiteView.layer.masksToBounds = YES;
    self.backgroundWhiteView.layer.cornerRadius = 30;
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"twitter"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imageView;
    
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadTweets{
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
            // Get timeline
            [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
                if (tweets) {
                    NSLog(@"😎😎😎 Successfully loaded home timeline");
                    //for (NSDictionary *dictionary in tweets) {
                        //NSString *text = dictionary[@"text"];
                        //NSLog(@"%@", text);
                    //}
                    self.tweets = tweets;
                    [self.tableView reloadData];
                    if (self.refreshControl.refreshing){
                        [self.refreshControl endRefreshing];
                    }
                } else {
                    NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
                }
            }];
    }];
}

-(void) setUpTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void) setUpRefreshControl{
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged];
}

-(void) logoutButtonPressed{
    // TimelineViewController.m
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

-(void) newTweetButtonPressed{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ComposeViewController *composeController = [storyboard instantiateViewControllerWithIdentifier:@"ComposeViewController"];
     composeController.delegate = self;
    composeController.contentSizeInPopup = CGSizeMake(300, 300);
    composeController.landscapeContentSizeInPopup = CGSizeMake(400, 200);
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:composeController];
    popupController.cornerRadius = 25;
    
    //UI Setup
    [STPopupNavigationBar appearance].barTintColor = UIColor.systemTealColor;
    [STPopupNavigationBar appearance].tintColor = [UIColor whiteColor];
    [STPopupNavigationBar appearance].barStyle = UIBarStyleDefault;
    [STPopupNavigationBar appearance].draggable = YES;
    [STPopupNavigationBar appearance].titleTextAttributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor whiteColor] };
    
    [popupController presentInViewController:self];
    
}

//MARK:- TableView Deleagte + Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    Tweet* tweet = self.tweets[indexPath.row];
    [cell setUpFromTweet:tweet];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storybaord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *vc = [storybaord instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.tweet = self.tweets[indexPath.row];
    vc.cellHeight = [tableView cellForRowAtIndexPath:indexPath].frame.size.height;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //1. Define the initial state (Before the animation)
    cell.transform = CGAffineTransformMakeTranslation(0.f, UITableViewAutomaticDimension);
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;

    //2. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.transform = CGAffineTransformMakeTranslation(0.f, 0);
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (void)didTweet:(nonnull Tweet *)tweet {
    NSArray<Tweet*> *newTweet = @[tweet];
    self.tweets = [newTweet arrayByAddingObjectsFromArray:self.tweets];
    [self.tableView reloadData];
}

@end
