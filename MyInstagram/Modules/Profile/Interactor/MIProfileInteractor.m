//
//  MIProfileInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIProfileInteractor.h"
#import "MIDataProvider+Authentication.h"
#import "MIDataProvider+User.h"
#import "MIImageCacheUtility.h"

@interface MIProfileInteractor ()

@end

@implementation MIProfileInteractor

#pragma mark - MIProfileInteractorInputInterface

- (void)getLocalUser
{
    MIInstagramUser *user = (MIInstagramUser *)[self.dataProvider localUser];
    
    [_presenter showUser:user];
    
    [self downloadContentForUser:user];
}

- (void)getUser
{
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider getUserInfoWithSuccessBlock:^(NSObject *data)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        MIInstagramUser *user = (MIInstagramUser *)data;
        
        [strongSelf.presenter showUser:user];
        
        [self downloadContentForUser:user];
    }
                                      failureBlock:^(NSString *error){}];
}

- (void)logout
{
    __weak typeof(self) weakSelf = self;
    
    [self.dataProvider logoutWithCompletion:^(BOOL success)
    {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (success)
        {
            [strongSelf.presenter showLoginInterface];
        }
    }];
}

@end
