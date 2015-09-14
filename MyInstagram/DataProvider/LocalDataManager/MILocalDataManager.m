//
//  MIAppDataStore.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILocalDataManager.h"
#import "MagicalRecord.h"
#import "FEMDeserializer.h"
#import "FEMSerializer.h"
#import "InstagramUser.h"
#import "InstagramList.h"
#import "InstagramPost.h"
#import "InstagramComment.h"
#import "MIMappingManager.h"

#import "MIConstants.h"

@implementation MILocalDataManager

#pragma mark - Initialization

+ (instancetype)sharedInstance
{
    static MILocalDataManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        _sharedInstance = [MILocalDataManager new];
    });
    
    return _sharedInstance;
}

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

#pragma mark - Others

- (void)setup
{
    [MagicalRecord setupCoreDataStack];
}

- (void)clearData
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext)
    {
        [InstagramUser MR_truncateAllInContext:localContext];
        [InstagramList MR_truncateAllInContext:localContext];
        [InstagramPost MR_truncateAllInContext:localContext];
        [InstagramComment MR_truncateAllInContext:localContext];
    }];
}

@end
