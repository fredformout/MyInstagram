//
//  MILoginRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILoginRouter.h"
#import "MILoginViewController.h"
#import "MILoginInterface.h"

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

- (void)presentLoginInterfaceFromViewController:(UIViewController *)fromViewController
{
    UIViewController *viewController = [self initializedViewController];
    
//    [self.addPresenter configureUserInterfaceForPresentation:addViewController];
    
    [fromViewController presentViewController:viewController
                                 animated:YES
                               completion:nil];
    
    self.presentedViewController = fromViewController;
}

- (void)dismissLoginInterface
{
    [self.presentedViewController dismissViewControllerAnimated:YES
                                                     completion:nil];
}

- (UIViewController *)initializedViewController
{
    UIViewController *viewController = [self viewController];
    ((MILoginViewController *)viewController).actionsHandler = (id<MILoginInterface>)self.presenter;
    viewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    return viewController;
}

@end
