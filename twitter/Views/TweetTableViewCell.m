//
//  TweetTableViewCell.m
//  twitter
//
//  Created by Keng Fontem on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetTableViewCell.h"

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

@end
