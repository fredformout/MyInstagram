//
//  MiProfileRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIProfileRouter.h"
#import "MIProfilePresenter.h"
#import "MiProfileViewController.h"

@implementation MIProfileRouter

- (NSString *)viewControllerIdentifier
{
    return @"ProfileViewController";
}

- (UIViewController *)initializedViewController
{
    UIViewController *viewControllerToPresent = [self viewController];
    MIProfileViewController *viewController = (MIProfileViewController *)viewControllerToPresent;
    
    if ([viewControllerToPresent isKindOfClass:[UINavigationController class]])
    {
        viewController = ((UINavigationController *)viewControllerToPresent).viewControllers[0];
    }
    
    MIProfilePresenter *presenter = (MIProfilePresenter *)self.presenter;
    
    viewController.actionsHandler = presenter;
    
    return viewControllerToPresent;
}

@end
