//
//  MIPopularPhotosRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIPhotosRouter.h"
#import "MIPhotosCollectionViewController.h"
#import "MIPhotosPresenter.h"

@implementation MIPhotosRouter

#pragma mark - MIBaseRouter

- (UIViewController *)viewControllerFromStoryboard
{
    UIViewController *viewControllerToPresent = [super viewControllerFromStoryboard];
    
    MIPhotosCollectionViewController *viewController = (MIPhotosCollectionViewController *)self.viewController;
    MIPhotosPresenter *presenter = (MIPhotosPresenter *)self.presenter;
    
    presenter.controller = viewController;
    viewController.presenter = presenter;
    
    return viewControllerToPresent;
}

#pragma mark - Others

- (void)presentPhotoDetails
{
    [_photoDetailsRouter presentViewControllerFromViewController:self.viewController];
}

@end
