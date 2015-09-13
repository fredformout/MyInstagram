//
//  MILoginInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MILoginInteractor.h"
#import "MIAuthenticationDataProvider.h"
#import "MILoginPresenter.h"
#import "MIUsersDataProvider.h"

@interface MILoginInteractor ()

@end

@implementation MILoginInteractor

#pragma mark - Others

- (void)checkAPIRequestsAvailability
{
    [MIAuthenticationDataProvider startNetworkMonitoring];
    
    NSString *accessToken = [MIAuthenticationDataProvider accessToken];
    
    if (!accessToken)
    {
        [_presenter loginInstagram];
    }
}

- (void)getLoginURLRequest
{
    [_presenter processLoginURLRequest:[MIAuthenticationDataProvider loginURLRequest]];
}

- (void)processResponseWithURL:(NSURL *)url
{
    [MIAuthenticationDataProvider processResponseWithURL:url
                                              completion:^(BOOL success)
    {
        [_presenter finishLoginWithSuccess:success];
        
        [MIUsersDataProvider getUserInfoWithSuccessBlock:nil
                                            failureBlock:nil];
    }];
}

@end
