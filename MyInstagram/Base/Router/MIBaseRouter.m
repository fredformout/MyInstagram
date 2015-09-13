//
//  MIBaseRouter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseRouter.h"
#import "MIBasePresenter.h"

static NSString *kMainStoryboardName = @"Main";

@interface MIBaseRouter ()

@end

@implementation MIBaseRouter

#pragma mark - Initialization

- (instancetype)initWithViewControllerIdentifier:(NSString *)viewControllerIdentifier
{
    self = [super init];
    
    if (self)
    {
        self.viewControllerIdentifier = viewControllerIdentifier;
    }
    
    return self;
}

#pragma mark - Others

- (UIViewController *)viewControllerFromStoryboard
{
    NSString *viewControllerIdentifier = [self viewControllerIdentifier];
    
    if (viewControllerIdentifier)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMainStoryboardName
                                                             bundle:[NSBundle mainBundle]];
        
        self.viewControllerToPresent = [storyboard instantiateViewControllerWithIdentifier:viewControllerIdentifier];
        
        UIViewController *viewController = _viewControllerToPresent;
        
        if ([_viewControllerToPresent isKindOfClass:[UINavigationController class]])
        {
            viewController = ((UINavigationController *)_viewControllerToPresent).viewControllers[0];
        }
        
        self.viewController = viewController;
        self.presenter.viewController = _viewController;
    }
    
    return _viewControllerToPresent;
}

@end
