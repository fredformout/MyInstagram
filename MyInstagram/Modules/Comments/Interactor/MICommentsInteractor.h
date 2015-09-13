//
//  MICommentsInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 11.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MICommentsInteractorIOInterface.h"
#import "MIAddCommentInteractorIOInterface.h"

@interface MICommentsInteractor : NSObject <MICommentsInteractorInputInterface, MIAddCommentInteractorInputInterface>

@property (nonatomic, weak) id<MICommentsInteractorOutputInterface, MIAddCommentInteractorOutputInterface> presenter;

@end
