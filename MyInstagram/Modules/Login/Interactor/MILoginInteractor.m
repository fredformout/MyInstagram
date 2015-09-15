//
//  MILoginInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MILoginInteractor.h"
#import "MILoginPresenter.h"
#import "MIDataProvider+Authentication.h"
#import "MIDataProvider+User.h"
#import "MIInstagramUser.h"
#import "MIImageCacheUtility.h"

@interface MILoginInteractor ()

@end

@implementation MILoginInteractor

#pragma mark - Others

- (void)checkAPIRequestsAvailability
{
    [self.dataProvider startNetworkMonitoring];
    
    NSString *accessToken = [self.dataProvider accessToken];
    
    if (!accessToken)
    {
        [_presenter loginInstagram];
    }
}

- (void)getLoginURLRequest
{
    [_presenter processLoginURLRequest:[self.dataProvider loginURLRequest]];
}

- (void)processResponseWithURL:(NSURL *)url
{
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider processResponseWithURL:url
                                   completion:^(BOOL success)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.presenter finishLoginWithSuccess:success];
        
        [strongSelf.dataProvider getUserInfoWithSuccessBlock:^(NSObject *data)
        {
            MIInstagramUser *user = (MIInstagramUser *)data;
            
            [self downloadContentForUser:user];
        }
                                                failureBlock:^(NSString *error){}];
    }];
}

@end
