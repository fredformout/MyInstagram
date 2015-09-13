//
//  MIPhotoDetailsRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotoDetailsRouter.h"
#import "MIPhotoDetailsPresenter.h"
#import "MIPhotoDetailsViewController.h"
#import "MITransitionFromPhotosToPhotoDetails.h"
#import "MITransitionFromPhotoDetailsToPhotos.h"

@interface MIPhotoDetailsRouter ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation MIPhotoDetailsRouter

#pragma mark - MIBaseRouter

- (NSString *)viewControllerIdentifier
{
    return @"PhotoDetailsViewController";
}

- (UIViewController *)viewControllerFromStoryboard
{
    UIViewController *viewControllerToPresent = [super viewControllerFromStoryboard];
    
    MIPhotoDetailsViewController *viewController = (MIPhotoDetailsViewController *)self.viewController;
    MIPhotoDetailsPresenter *presenter = (MIPhotoDetailsPresenter *)self.presenter;
    
    presenter.controller = viewController;
    viewController.presenter = presenter;
    
    return viewControllerToPresent;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if ([fromVC isEqual:self.viewController])
    {
        return [[MITransitionFromPhotoDetailsToPhotos alloc] init];
    }
    else
    {
        return [[MITransitionFromPhotosToPhotoDetails alloc] init];
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactivePopTransition;
}

#pragma mark - Others

- (void)setTransitioningDelegate
{
    self.viewController.navigationController.delegate = self;
}

- (void)unsetTransitioningDelegate
{
    UIViewController *viewController = self.viewController;
    
    if (viewController.navigationController.delegate == self)
    {
        viewController.navigationController.delegate = nil;
    }
}

- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer*)recognizer
{
    CGFloat progress = [recognizer translationInView:self.viewController.view].x / (self.viewController.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        self.interactivePopTransition = [UIPercentDrivenInteractiveTransition new];
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded
             || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        if (progress > 0.5)
        {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else
        {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
}

- (void)presentViewControllerFromViewController:(UIViewController *)fromVC
{
    fromVC.navigationController.delegate = self;
    
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                        action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    
    UIViewController *viewControllerToPresent = [self viewControllerFromStoryboard];
    [viewControllerToPresent.view addGestureRecognizer:popRecognizer];
    
    [fromVC.navigationController pushViewController:viewControllerToPresent
                                           animated:YES];
}

- (void)presentComments
{
    [_commentsRouter presentViewControllerFromViewController:self.viewController];
}

@end
