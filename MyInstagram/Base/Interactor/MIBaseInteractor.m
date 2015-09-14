//
//  MIBaseInteractor.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 13.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIBaseInteractor.h"

@interface MIBaseInteractor ()

@end

@implementation MIBaseInteractor

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _dataProvider = [MIDataProvider new];
    }
    
    return self;
}

@end
