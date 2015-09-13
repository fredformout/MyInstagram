//
//  MILoginPresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILoginPresenter.h"
#import "MILoginRouter.h"

@implementation MILoginPresenter

#pragma mark - MILoginPresenterInterface

- (void)loginAction
{
    [_interactor getLoginURLRequest];
}

#pragma mark - MILoginInteractorOutputInterface

- (void)loginInstagram
{
    [_appRouter presentLoginViewController];
}

- (void)processLoginURLRequest:(NSURLRequest *)urlRequest
{
    [_controller openURL:urlRequest];
}

- (void)finishLoginWithSuccess:(BOOL)success
{
    if (success)
    {
        MILoginRouter *router = (MILoginRouter *)self.router;
        
        [router dismissViewController];
    }
}

#pragma mark - Others

- (void)checkAPIRequestsAvailability
{
    [_interactor checkAPIRequestsAvailability];
}

- (void)processResponseWithURL:(NSURL *)url
{
    [_interactor processResponseWithURL:url];
}

@end
