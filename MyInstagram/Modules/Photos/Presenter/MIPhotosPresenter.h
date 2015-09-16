//
//  MIPopularPhotosPresenter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIBasePresenter.h"
#import "MIPhotosPresenterInterface.h"
#import "MIPhotosViewControllerInterface.h"
#import "MIPhotosInteractorIOInterface.h"
#import "MIPhotoDetailsPresenterInterface.h"
#import "MINetworkActivityInteractorInputInterface.h"

@interface MIPhotosPresenter : MIBasePresenter <MIPhotosPresenterInterface, MIPhotosInteractorOutputInterface>

@property (nonatomic, weak) id<MIPhotosViewControllerInterface> controller;
@property (nonatomic, strong) id<MIPhotosInteractorInputInterface, MINetworkActivityInteractorInputInterface> interactor;

@property (nonatomic, strong) id<MIPhotoDetailsPresenterInterface> photoDetailsPresenter;

@end
