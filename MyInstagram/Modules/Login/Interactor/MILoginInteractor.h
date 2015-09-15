//
//  MILoginInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIDownloadUserContentInteractor.h"
#import "MILoginInteractorIOInterface.h"

@interface MILoginInteractor : MIDownloadUserContentInteractor <MILoginInteractorInputInterface>

@property (nonatomic, weak) id<MILoginInteractorOutputInterface> presenter;

@end
