//
//  MIPopularPhotosRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosRouter.h"
#import "MIPhotosViewController.h"
#import "MIPhotosPresenter.h"

@implementation MIPhotosRouter

#pragma mark - MIBaseRouter

- (NSString *)viewControllerIdentifier
{
    return @"PhotosViewController";
}

- (UIViewController *)initializedViewController
{
    UIViewController *viewControllerToPresent = [self viewController];
    MIPhotosViewController *viewController = (MIPhotosViewController *)viewControllerToPresent;
    
    if ([viewControllerToPresent isKindOfClass:[UINavigationController class]])
    {
        viewController = ((UINavigationController *)viewControllerToPresent).viewControllers[0];
    }
    
    MIPhotosPresenter *presenter = (MIPhotosPresenter *)self.presenter;
    
    viewController.actionsHandler = presenter;
    
    return viewControllerToPresent;
}

@end
