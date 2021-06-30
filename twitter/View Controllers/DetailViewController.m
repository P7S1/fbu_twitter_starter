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
@property (nonatomic, strong) NSArray<Tweet *>* tweets;
@property (nonatomic) BOOL hasSetUpHeader;
@property (nonatomic, strong) TweetTableViewCell* headerView;
@end
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}

-(void)setUpTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.hasSetUpHeader = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil]
       forCellReuseIdentifier:@"TweetTableViewCell"];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!self.hasSetUpHeader){
        self.hasSetUpHeader = YES;
        self.headerView = [[UINib alloc]instantiateWithOwner:@"TweetTableViewCell" options:nil][0];
        [self.headerView setUpFromTweet:self.tweet];
        return self.headerView;
    }else{
        return self.headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc]init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

@end
