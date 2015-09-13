//
//  AppRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAppRouter.h"
#import "UIViewController+EmptyBackButton.h"

@implementation MIAppRouter

#pragma mark - MIBaseRouter

- (NSString *)viewControllerIdentifier
{
    return @"AppTabBarController";
}

#pragma mark - Others

- (void)presentAppViewControllerFromWindow:(UIWindow *)window
{
    UITabBarController *tabBarController = (UITabBarController *)[self viewControllerFromStoryboard];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    for (MIBaseRouter *router in _innerRouters)
    {
        [viewControllers addObject:[router viewControllerFromStoryboard]];
    }
    
    tabBarController.viewControllers = viewControllers;
    
    window.rootViewController = tabBarController;
    [window makeKeyAndVisible];
}

- (void)presentLoginViewController
{
    [_loginRouter presentViewControllerFromViewController:self.viewController];
}

@end
