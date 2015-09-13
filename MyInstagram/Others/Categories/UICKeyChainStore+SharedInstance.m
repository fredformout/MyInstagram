//
//  UICKeyChainStore+SharedInstance.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 10.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "UICKeyChainStore+SharedInstance.h"
#import "MIInstagramConstants.h"

@implementation UICKeyChainStore (SharedInstance)

#pragma mark - Initialization

+ (instancetype)sharedInstance
{
    static UICKeyChainStore *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        _sharedInstance = [UICKeyChainStore keyChainStoreWithService:kInstagramKeychainStore];
    });
    
    return _sharedInstance;
}

@end
