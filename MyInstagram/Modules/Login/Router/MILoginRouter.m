//
//  MILoginRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILoginRouter.h"
#import "MILoginViewController.h"
#import "MILoginPresenter.h"

@interface MILoginRouter ()

@property (nonatomic, strong) UIViewController *presentedViewController;

@end

@implementation MILoginRouter

#pragma mark - MIBaseRouter

- (NSString *)viewControllerIdentifier
{
    return @"LoginViewController";
}

#pragma mark - Others

- (void)presentViewControllerFromViewController:(UIViewController *)fromVC
{
    UIViewController *viewController = [self viewControllerFromStoryboard];
    
    [fromVC presentViewController:viewController
                         animated:YES
                       completion:nil];
}

- (void)dismissViewController
{
    [self.viewControllerToPresent dismissViewControllerAnimated:YES
                                                     completion:nil];
}

- (UIViewController *)viewControllerFromStoryboard
{
    UIViewController *viewControllerToPresent = [super viewControllerFromStoryboard];
    
    MILoginViewController *viewController = (MILoginViewController *)self.viewController;
    MILoginPresenter *presenter = (MILoginPresenter *)self.presenter;

    presenter.controller = viewController;
    viewController.presenter = presenter;
    
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverFullScreen;
    viewControllerToPresent.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    return viewControllerToPresent;
}

@end
