//
//  MISlaveByTabBarControllerRouter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseRouter.h"
#import "MITabBarItemInfo.h"

@interface MISlaveByTabBarControllerRouter : MIBaseRouter

- (instancetype)initWithViewControllerIdentifier:(NSString *)viewControllerIdentifier
                                           title:(NSString *)title
                                  tabBarItemInfo:(MITabBarItemInfo *)tabBarItemInfo;

@end
