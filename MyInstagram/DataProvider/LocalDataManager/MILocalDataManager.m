//
//  MIAppDataStore.m
//  MyInstagram
//
//  Created by Vladimir Vasilev on 07.09.15.
//  Copyright (c) 2015 Vladimir Vasilev. All rights reserved.
//

#import "MILocalDataManager.h"
#import "MagicalRecord.h"

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

- (void)saveData:(NSDictionary *)data
     mapperClass:(NSString *)mapperClass
      completion:(dispatch_block_t)completion
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext)
    {
//        Class class = NSClassFromString(mapperClass);
//        [class mapData:data
//               context:localContext];
    }
                      completion:^(BOOL contextDidSave, NSError *error)
    {
        if (contextDidSave
            && completion)
        {
            completion();
        }
    }];
}

- (NSArray *)getAllEntitiesByClass:(NSString *)className
{
    if ([className isEqualToString:@"Post"])
    {
//        return [Post MR_findAll];
    }
    
    return nil;
}

@end
