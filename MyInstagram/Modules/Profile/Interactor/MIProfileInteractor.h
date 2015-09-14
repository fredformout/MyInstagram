//
//  MIProfileInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIBaseInteractor.h"
#import "MIProfileInteractorIOInterface.h"

@interface MIProfileInteractor : MIBaseInteractor <MIProfileInteractorInputInterface>

@property (nonatomic, weak) id<MIProfileInteractorOutputInterface> presenter;

@end
