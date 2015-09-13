//
//  MIPhotoDetailsInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 09.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIAddCommentInteractorIOInterface.h"
#import "MIPhotoDetailsInteractorIOInterface.h"

@interface MIPhotoDetailsInteractor : NSObject <MIAddCommentInteractorInputInterface, MIPhotoDetailsInteractorInputInterface>

@property (nonatomic, weak) id<MIAddCommentInteractorOutputInterface, MIPhotoDetailsInteractorOutputInterface> presenter;

@end
