//
//  User.m
//  twitter
//
//  Created by Keng Fontem on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        int userIdInt = [dictionary[@"id"] intValue];
        self.userId = [NSString stringWithFormat:@"%i", userIdInt];
    // Initialize any other properties
    }
    return self;
}

- (NSURL *) getUserURL{
    NSString *URLString = self.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    return url;
}
@end
