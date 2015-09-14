//
//  MIBasePresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBasePresenter.h"
#import "UIViewController+InitialState.h"

@implementation MIBasePresenter

#pragma mark - Others

- (void)returnViewControllerToInitialState
{
    [_viewController returnToInitialState];
}

- (void)performFirstActions
{
    [_viewController firstActions];
}

@end
