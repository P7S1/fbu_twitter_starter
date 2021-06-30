//
//  User.h
//  twitter
//
//  Created by Keng Fontem on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

// Add properties

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString* userId;
// TODO: Create initializer
// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSURL*)getUserURL;
@end

NS_ASSUME_NONNULL_END
