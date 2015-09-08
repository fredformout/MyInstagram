//
//  MISlaveByTabBarControllerRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MISlaveByTabBarControllerRouter.h"

@interface MISlaveByTabBarControllerRouter ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) MITabBarItemInfo *tabBarItemInfo;

@end

@implementation MISlaveByTabBarControllerRouter

#pragma mark - Initialization

- (instancetype)initWithViewControllerIdentifier:(NSString *)viewControllerIdentifier
                                           title:(NSString *)title
                                  tabBarItemInfo:(MITabBarItemInfo *)tabBarItemInfo
{
    self = [super initWithViewControllerIdentifier:viewControllerIdentifier];
    
    if (self)
    {
        self.title = title;
        self.tabBarItemInfo = tabBarItemInfo;
    }
    
    return self;
}

#pragma mark - MIBaseRouter

- (UIViewController *)viewController
{
    UIViewController *viewController = [super viewController];
    UIViewController *viewControllerToSetup = viewController;
    
    if ([viewControllerToSetup isKindOfClass:[UINavigationController class]])
    {
        viewControllerToSetup = ((UINavigationController *)viewControllerToSetup).viewControllers[0];
    }
    
    viewControllerToSetup.title = _title;
    viewControllerToSetup.tabBarItem.title = _tabBarItemInfo.title;
    viewControllerToSetup.tabBarItem.image = [UIImage imageNamed:_tabBarItemInfo.imageName];
    
    return viewController;
}

@end
