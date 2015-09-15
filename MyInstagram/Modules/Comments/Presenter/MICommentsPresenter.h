//
//  MICommentsPresenter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBasePresenter.h"
#import "MICommentsPresenterInterface.h"
#import "MICommentsViewControllerInterface.h"
#import "MICommentsInteractorIOInterface.h"
#import "MIAddCommentInteractorIOInterface.h"
#import "MIAddCommentPresenterInterface.h"
#import "MIAddCommentViewControllerInterface.h"

@interface MICommentsPresenter : MIBasePresenter <MICommentsPresenterInterface, MICommentsInteractorOutputInterface, MIAddCommentInteractorOutputInterface, MIAddCommentPresenterInterface>

@property (nonatomic, weak) id<MICommentsViewControllerInterface, MIAddCommentViewControllerInterface> controller;
@property (nonatomic, strong) id<MICommentsInteractorInputInterface, MIAddCommentInteractorInputInterface> interactor;

@end
