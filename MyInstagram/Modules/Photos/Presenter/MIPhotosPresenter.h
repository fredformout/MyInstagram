//
//  MIPopularPhotosPresenter.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIBasePresenter.h"
#import "MIPhotosInterface.h"
#import "MIPhotosViewControllerInterface.h"
#import "MIPhotosInteractorInputInterface.h"
#import "MIPhotosInteractorOutputInterface.h"

@interface MIPhotosPresenter : MIBasePresenter <MIPhotosInterface, MIPhotosInteractorOutputInterface>

@property (nonatomic, strong) id<MIPhotosViewControllerInterface> viewController;
@property (nonatomic, strong) id<MIPhotosInteractorInputInterface> interactor;

@end
