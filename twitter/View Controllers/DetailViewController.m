//
//  DetailViewController.m
//  twitter
//
//  Created by Keng Fontem on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "TweetTableViewCell.h"
@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Tweet *>* tweets;

@end
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweets = [[NSMutableArray<Tweet*> alloc]init];
    [self setUpTableView];
}

-(void)setUpTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TweetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    [cell setUpFromTweet:self.tweet];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    [cell setUpFromTweet:tweet];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight + 20;
}

@end
