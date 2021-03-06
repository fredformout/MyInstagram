//
//  MIPhotosInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 08.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIPhotosInteractor.h"
#import "MIPhotosInteractorIOInterface.h"

@interface MIPopularPhotosInteractor : MIPhotosInteractor <MIPhotosInteractorInputInterface>

@property (nonatomic, weak) id<MIPhotosInteractorOutputInterface> presenter;

@end
