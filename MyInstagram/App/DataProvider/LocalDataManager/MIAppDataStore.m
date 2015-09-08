//
//  MIAppDataStore.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MIAppDataStore.h"
#import "MagicalRecord+Setup.h"

@implementation MIAppDataStore

#pragma mark - Initialization

+ (instancetype)sharedInstance
{
    static MIAppDataStore *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        _sharedInstance = [MIAppDataStore new];
    });
    
    return _sharedInstance;
}

#pragma mark - Others

- (void)setup
{
    [MagicalRecord setupCoreDataStack];
}

@end
