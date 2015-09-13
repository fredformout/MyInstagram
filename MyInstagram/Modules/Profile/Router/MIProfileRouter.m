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

#pragma mark - MIBaseRouter

- (UIViewController *)viewControllerFromStoryboard
{
    UIViewController *viewControllerToPresent = [super viewControllerFromStoryboard];

    MIProfileViewController *viewController = (MIProfileViewController *)self.viewController;
    MIProfilePresenter *presenter = (MIProfilePresenter *)self.presenter;
    
    viewController.presenter = presenter;
    presenter.controller = viewController;
    
    return viewControllerToPresent;
}

@end
