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

- (UIViewController *)viewController
{
    UIViewController *viewController = nil;
    
    NSString *viewControllerIdentifier = [self viewControllerIdentifier];
    
    if (viewControllerIdentifier)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kMainStoryboardName
                                                             bundle:[NSBundle mainBundle]];
        
        viewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerIdentifier];
    }
    
    return viewController;
}

@end
