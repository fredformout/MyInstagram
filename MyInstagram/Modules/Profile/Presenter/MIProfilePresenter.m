//
//  MIProfilePresenter.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIProfilePresenter.h"

@interface MIProfilePresenter ()

@property (nonatomic, strong) MIInstagramUser *user;

@end

@implementation MIProfilePresenter

#pragma mark - MIBasePresenter

- (void)returnViewControllerToInitialState
{
    self.user = nil;
    
    [_controller showUser:_user];
    
    [super returnViewControllerToInitialState];
}

#pragma mark - MIProfilePresenterInterface

- (void)initView
{
    [_interactor getLocalUser];
}

- (void)getUser
{
    [_interactor getUser];
}

- (void)logoutAction
{
    [_interactor logout];
}

#pragma mark - MIProfileInteractorOutputInterface

- (void)showUser:(MIInstagramUser *)user
{
    self.user = user;
    [_controller showUser:user];
}

- (void)showLoginInterface
{
    [_appRouter presentLoginViewController];
}

@end
