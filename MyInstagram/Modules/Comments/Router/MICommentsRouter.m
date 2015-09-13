//
//  MICommentsRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MICommentsRouter.h"
#import "MICommentsPresenter.h"
#import "MICommentsViewController.h"

@implementation MICommentsRouter

#pragma mark - MIBaseRouter

- (NSString *)viewControllerIdentifier
{
    return @"CommentsViewController";
}

- (UIViewController *)viewControllerFromStoryboard
{
    UIViewController *viewControllerToPresent = [super viewControllerFromStoryboard];
    
    MICommentsViewController *viewController = (MICommentsViewController *)self.viewController;
    MICommentsPresenter *presenter = (MICommentsPresenter *)self.presenter;
    
    presenter.controller = viewController;
    viewController.presenter = presenter;
    
    return viewControllerToPresent;
}

#pragma mark - Others

- (void)presentViewControllerFromViewController:(UIViewController *)fromVC
{
    fromVC.navigationController.delegate = nil;
    
    UIViewController *viewControllerToPresent = [self viewControllerFromStoryboard];
    
    [fromVC.navigationController pushViewController:viewControllerToPresent
                                           animated:YES];
}

@end
