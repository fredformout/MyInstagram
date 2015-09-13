//
//  MIProfilePresenter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBasePresenter.h"
#import "MIProfilePresenterInterface.h"
#import "MIProfileViewControllerInterface.h"
#import "MIProfileInteractorIOInterface.h"
#import "MIAppRouter.h"

@interface MIProfilePresenter : MIBasePresenter <MIProfilePresenterInterface, MIProfileInteractorOutputInterface>

@property (nonatomic, weak) MIAppRouter *appRouter;
@property (nonatomic, weak) id<MIProfileViewControllerInterface> controller;
@property (nonatomic, strong) id<MIProfileInteractorInputInterface> interactor;

@end
