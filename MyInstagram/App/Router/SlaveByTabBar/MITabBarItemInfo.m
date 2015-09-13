//
//  MITabBarItemInfo.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MITabBarItemInfo.h"

@implementation MITabBarItemInfo

#pragma mark - Initialization

- (instancetype)initWithTitle:(NSString *)title
                    imageName:(NSString *)imageName
{
    self = [super init];
    
    if (self)
    {
        self.title = title;
        self.imageName = imageName;
    }
    
    return self;
}

@end
