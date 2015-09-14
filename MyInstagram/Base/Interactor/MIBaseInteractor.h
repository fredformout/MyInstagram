//
//  MIBaseInteractor.h
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIDataProvider.h"

@interface MIBaseInteractor : NSObject

@property (nonatomic, strong) MIDataProvider *dataProvider;

@end
