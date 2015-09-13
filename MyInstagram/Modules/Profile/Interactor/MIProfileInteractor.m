//
//  MIProfileInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIProfileInteractor.h"
#import "MIUsersDataProvider.h"
#import "MIAuthenticationDataProvider.h"

@interface MIProfileInteractor ()

@end

@implementation MIProfileInteractor

#pragma mark - MIProfileInteractorInputInterface

- (void)getUser
{
    [MIUsersDataProvider getUserInfoWithSuccessBlock:^(NSObject *data)
    {
        [_presenter showUser:(MIInstagramUser *)data];
    }
                                          failureBlock:^(NSString *error){}];
}

- (void)logout
{
    [MIAuthenticationDataProvider logoutWithCompletion:^(BOOL success)
    {
        if (success)
        {
            [_presenter showLoginInterface];
        }
    }];
}

@end
