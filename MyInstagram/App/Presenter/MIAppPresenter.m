//
//  MIAppPresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAppPresenter.h"
#import "MIAppRouter.h"

@implementation MIAppPresenter

#pragma mark - Others

- (void)showAppViewControllerFromWindow:(UIWindow *)window
{
    MIAppRouter *router = (MIAppRouter *)self.router;
    
    [router presentAppViewControllerFromWindow:window];
}

- (void)returnAppInitialState
{
    for (MIBasePresenter *presenter in _innerPresenters)
    {
        [presenter returnViewControllerToInitialState];
    }
}

@end
