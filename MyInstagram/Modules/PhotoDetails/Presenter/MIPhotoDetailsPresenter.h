//
//  MIPhotoDetailsPresenter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBasePresenter.h"
#import "MIPhotoDetailsPresenterInterface.h"
#import "MIPhotoDetailsViewControllerInterface.h"
#import "MIPhotosPresenterInterface.h"
#import "MICommentsPresenterInterface.h"
#import "MIAddCommentInteractorIOInterface.h"
#import "MIAddCommentPresenterInterface.h"
#import "MIPhotoDetailsInteractorIOInterface.h"
#import "MIAddCommentViewControllerInterface.h"

@interface MIPhotoDetailsPresenter : MIBasePresenter <MIPhotoDetailsPresenterInterface, MIAddCommentInteractorOutputInterface, MIAddCommentPresenterInterface, MIPhotoDetailsInteractorOutputInterface>

@property (nonatomic, weak) id<MIPhotoDetailsViewControllerInterface, MIAddCommentViewControllerInterface> controller;
@property (nonatomic, strong) id<MIAddCommentInteractorInputInterface, MIPhotoDetailsInteractorInputInterface> interactor;

@property (nonatomic, weak) id<MIPhotosPresenterInterface> photosPresenter;
@property (nonatomic, strong) id<MICommentsPresenterInterface> commentsPresenter;

@end
