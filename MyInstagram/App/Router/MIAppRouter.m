//
//  AppRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAppRouter.h"
#import "MIAppTabBarController.h"

@implementation MIAppRouter

#pragma mark - MIBaseRouter

- (NSString *)viewControllerIdentifier
{
    return @"AppTabBarController";
}

#pragma mark - Others

- (void)presentViewControllerFromWindow:(UIWindow *)window
{
    MIAppTabBarController *tabBarController = (MIAppTabBarController *)[self viewController];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    for (MIBaseRouter *router in _innerRouters)
    {
        [viewControllers addObject:[router viewController]];
    }
    
    tabBarController.viewControllers = viewControllers;
    
    window.rootViewController = tabBarController;
    [window makeKeyAndVisible];
}

@end
