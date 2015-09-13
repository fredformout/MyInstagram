//
//  MILoginPresenter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIBasePresenter.h"
#import "MILoginPresenterInterface.h"
#import "MILoginViewControllerInterface.h"
#import "MILoginInteractorIOInterface.h"
#import "MIAppRouter.h"
#import "MIAppPresenter.h"

@interface MILoginPresenter : MIBasePresenter <MILoginPresenterInterface, MILoginInteractorOutputInterface>

@property (nonatomic, weak) MIAppRouter *appRouter;
@property (nonatomic, weak) MIAppPresenter *appPresenter;

@property (nonatomic, weak) id<MILoginViewControllerInterface> controller;
@property (nonatomic, strong) id<MILoginInteractorInputInterface> interactor;

- (void)checkAPIRequestsAvailability;
- (void)processResponseWithURL:(NSURL *)url;

@end
