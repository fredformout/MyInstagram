//
//  MIProfilePresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIProfilePresenter.h"

@implementation MIProfilePresenter

#pragma mark - MIProfilePresenterInterface

- (void)logoutAction
{
    [_interactor logout];
}

- (void)getUser
{
    [_interactor getUser];
}

#pragma mark - MIProfileInteractorOutputInterface

- (void)showUser:(MIInstagramUser *)user
{
    [_controller showUser:user];
}

- (void)showLoginInterface
{
    [_appRouter presentLoginViewController];
}

@end
